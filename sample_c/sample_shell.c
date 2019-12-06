#include <time.h>
#include <stdio.h>
#include <errno.h>
#include <stdlib.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/ioctl.h>
#include <fcntl.h>
#include <termios.h>
#include <unistd.h>
#include "mrubyc.h"
#include "utils/xmodem.h"

#include "sample_shell_shell.c"
#include "sample_shell_main.c"

#define MEMORY_SIZE (1024*60)
static uint8_t memory_pool[MEMORY_SIZE];

#define BUFLEN 1024
static mrbc_tcb *shell_tcb;

typedef struct VMcode {
  long size;
  unsigned char *code;
} vm_code;

static xmodem_state*
init_xmodem(void)
{
  struct termios tio;
  int baudRate = B9600;
  tio.c_cflag = CREAD;
  tio.c_cflag += CLOCAL;
  tio.c_cflag += CS8;
  tio.c_cflag += IXON;
  cfsetispeed(&tio, baudRate);
  cfsetospeed(&tio, baudRate);
  cfmakeraw(&tio);
  tcsetattr(hal_fd, TCSANOW, &tio);
  ioctl(hal_fd, TCSETS, &tio);
  xmodem_state *x;
  x = (xmodem_state *)malloc(sizeof(xmodem_state));
  x->read = read;
  x->write = hal_write;
  x->fd = hal_fd;
  return x;
}

static void
c_gets(mrbc_vm *vm, mrbc_value *v, int argc)
{
  char buf[BUFLEN + 1];
  int len;
  len = read(hal_fd, buf, BUFLEN);
  if (len == -1) {
    perror("read");
    SET_NIL_RETURN();
    return;
  }
  if (len) {
    buf[len] = '\0'; // terminate;
    mrbc_value val = mrbc_string_new(vm, buf, len);
    SET_RETURN(val);
    return;
  }
  fprintf(stderr, "This should not happen (c_gets)\n");
}

static void
mrubyc_run(mrbc_vm *vm)
{
  if (vm == 0) {
    hal_write(hal_fd, "No VM!", 6);
  } else {
    mrbc_vm_begin(vm);
    mrbc_vm_run(vm);
    mrbc_value ret = mrbc_send(vm, vm->current_regs, 0, vm->current_regs, "inspect", 0);
    hal_write(hal_fd, "=> ", 3);
    hal_write(hal_fd, ret.string->data, ret.string->size);
    //mrbc_vm_end(vm);
  }
}

static void
c_xmodem(mrbc_vm *vm, mrbc_value *v, int argc)
{
  printf("XMODEM start\n");
  xmodem_state *x = init_xmodem();
  char loadbuf[BUFLEN];
  vm_code vms;
  vms.size = xmodem_recv(x, loadbuf);
  free(x);
  printf("XMODEM end\n");
  vms.code = malloc(sizeof(vms.size));
  memcpy(vms.code, loadbuf, vms.size);
  init_static();
  vm = mrbc_vm_open(NULL);
  vm->flag_write_current_reg = 1;
  vm->target_class = mrbc_get_class_by_name("String");
  if( vm == 0 ) {
    fprintf(stderr, "Can't open VM\n");
    return;
  }
  if(mrbc_load_mrb(vm, vms.code) != 0 ) {
    fprintf(stderr, "mrbc_load_mrb error\n");
    return;
  }
  mrubyc_run(vm);
}

static
void
resume_shell(void) {
  mrbc_resume_task(shell_tcb);
}

void
yomisute(void)
{
  fd_set readfds;
  FD_ZERO(&readfds);
  FD_SET(hal_fd, &readfds);
  struct timeval tv = { .tv_sec = 0, .tv_usec = 1 };
  while (select(hal_fd + 1, &readfds, NULL, NULL, &tv)) {
    char buf[BUFLEN + 1];
    read(hal_fd, buf, BUFLEN);
  }
}

int
main(int argc, char *argv[])
{
  hal_fd = open(argv[1], O_RDWR);
  //hal_fd = open(argv[1], O_RDWR|O_NONBLOCK);
  if (hal_fd < 0) {
    printf("open error\n");
    return -1;
  }
  printf("opened: %s\n", argv[1]);
  yomisute();
  sigset_t sigset;
  sigemptyset(&sigset);
  sigaddset(&sigset, SIGUSR1);
  struct sigaction act;
  act.sa_handler = resume_shell;
  act.sa_mask    = sigset;
  act.sa_flags   = SA_RESTART;
  sigaction(SIGUSR1, &act, 0);
  pid_t pid;
  pid = fork();
  if (pid < 0) {
    perror("fork");
    return 1;
  } else if (pid == 0) { // child process
    mrbc_init(memory_pool, MEMORY_SIZE);
    mrbc_define_method(0, mrbc_class_object, "gets", c_gets);
    mrbc_define_method(0, mrbc_class_object, "xmodem", c_xmodem);
    shell_tcb = mrbc_create_task(sample_shell_shell, 0);
    mrbc_create_task(sample_shell_main, 0);
    mrbc_run();
    printf("run\n");
    if (close(hal_fd) == -1) {
      perror("close");
      return 1;
    }
  } else if (pid > 0) { // parent process
    printf("successfully forked. parent pid: %d\n", pid);
    while (1) {
      fd_set readfds;
      FD_ZERO(&readfds);
      FD_SET(hal_fd, &readfds);
      struct timespec ts = { .tv_sec = 1, .tv_nsec = 0 };
      int ret;
      ret = select(hal_fd + 1, &readfds, NULL, NULL, NULL);
      if (ret == -1) {
        perror("select");
      } else if (ret == 0) {
        fprintf(stderr, "This should not happen (1)\n");
      } else if (ret > 0) {
        printf("Input recieved. Issuing SIGUSR1 to pid %d\n", pid);
        kill(pid, SIGUSR1);
        ret = clock_nanosleep(CLOCK_MONOTONIC, 0, &ts, NULL);
        if (ret)
          perror("clock_nanosleep");
      }
    }
  }
  return 0;
}
