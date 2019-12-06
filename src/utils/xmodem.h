#ifndef MRBC_UTILS_XMODEM_H_
#define MRBC_UTILS_XMODEM_H_

#ifdef __cplusplus
extern "C" {
#endif

typedef struct {
  ssize_t (*read)();
  ssize_t (*write)();
  int fd;
} xmodem_state;

long xmodem_recv(xmodem_state *x, char *buf);

#ifdef __cplusplus
}
#endif
#endif
