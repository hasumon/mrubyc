#include <stdio.h>
#include <string.h>
#include "../mrubyc.h"
#include "xmodem.h"

#define XMODEM_SOH 0x01
#define XMODEM_STX 0x02
#define XMODEM_EOT 0x04
#define XMODEM_ACK 0x06
#define XMODEM_NAK 0x15
#define XMODEM_CAN 0x18
#define XMODEM_EOF 0x1a /* Ctrl-Z */
char ack = XMODEM_ACK;
char nak = XMODEM_NAK;
char can = XMODEM_CAN;

#define XMODEM_BLOCK_SIZE 128

static int xmodem_wait(xmodem_state *x)
{
  x->write(x->fd, &nak, 1);
  usleep(1000);
  return 0;
}

static unsigned char xmodem_read_char(xmodem_state *x) {
  unsigned char c;
  int len;
  while(1) {
    len = x->read(x->fd, &c, 1);
    if (len == 1) {
      return c;
    }
  }
}

static int xmodem_read_block(xmodem_state *x, unsigned char block_number, char *buf)
{
  printf("block_number: %d\n", block_number);
  unsigned char c, block_num, check_sum;
  int i;

  //block_num = (unsigned char)getchar();
  c = xmodem_read_char(x);
  block_num = (unsigned char)c;
  printf("block_num: %d\n", block_num);
  if (block_num != block_number)
  {
    printf("fail_0\n");
    return -1;
  }

  //block_num ^= (int)getchar();
  c = xmodem_read_char(x);
  block_num ^= (int)c;
  if (block_num != 0xff)
  {
    printf("fail_1\n");
    return -1;
  }

  check_sum = 0;
  for(i = 0; i < XMODEM_BLOCK_SIZE; i++) {
    c = xmodem_read_char(x);
    // printf("%02x ", c);
    *(buf++) = (unsigned char)c;
    check_sum += c;
  }

  //check_sum ^= (int)getchar();
  c = xmodem_read_char(x);
  check_sum ^= (int)c;
  if (check_sum)
    return -1;

  return i;
}

long xmodem_recv(xmodem_state *x, char *buf)
{
  int r, receiving = 0;
  long size = 0;
  unsigned char c, block_number = 1;
  for (;;) {
    if (!receiving)
      xmodem_wait(x);

    c = xmodem_read_char(x);

    if (c == XMODEM_EOT) {
      x->write(x->fd, &ack, 1);
      break;
    } else if (c == XMODEM_CAN) {
      return -1;
    } else if (c == XMODEM_SOH) {
      receiving++;
      r = xmodem_read_block(x, block_number, buf);
      if (r < 0) {
        x->write(x->fd, &nak, 1);
      } else {
        block_number++;
        size += r;
        buf += r;
        x->write(x->fd, &ack, 1);
      }
    } else {
      if (receiving)
        return -1;
    }
  }
  /* Truncate EOF*/
  signed int offset = 0;
  buf--;
  for(;;){
    if (*(buf - offset) != (unsigned char)XMODEM_EOF)
      return (size - offset);
    offset++;
  }
}
