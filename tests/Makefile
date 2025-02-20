
ARCH = arm64
ROOTDIR  = $(shell pwd)
TOPDIR = $(ROOTDIR)
HOSTCC   = cc

CROSS_COMPILE = aarch64-openwrt-linux-musl-
COMPILE_HOST = arm-openwrt-linux
KERNELTARGET=Image
MAKEARCH = $(MAKE) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE)
TOOLPREFIX = $(CROSS_COMPILE)
COMPILER_PATH_ROOT:=$(subst /bin/,,$(dir $(shell which $(CROSS_COMPILE)gcc)))
CLIBC_DIR = $(COMPILER_PATH_ROOT)/lib
TOOLCHAIN_DIR = $(COMPILER_PATH_ROOT)

export CC=$(CROSS_COMPILE)gcc
export AR=$(CROSS_COMPILE)ar
export LD=$(CROSS_COMPILE)ld
export STRIP=$(CROSS_COMPILE)strip
export RANLIB=$(CROSS_COMPILE)ranlib
export USRLIBDIR=$(CLIBC_DIR)

OBJS = hello.c

all:
	$(CC) $(CFLAGS) -o hello $(OBJS) $(LDFLAGS)
