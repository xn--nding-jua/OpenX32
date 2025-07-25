#
# Makefile
#

CC              = arm-linux-gnueabi-gcc
CXX             = arm-linux-gnueabi-g++
AR              = arm-linux-gnueabi-ar
LD              = arm-linux-gnueabi-ld

LVGL_DIR_NAME   ?= lvgl
LVGL_DIR        ?= ./lv_port_linux
LVGL_PATH       = demosAreDisabledByThisHack

WARNINGS        := -Wall -Wshadow -Wundef -Wmissing-prototypes -Wno-discarded-qualifiers -Wextra -Wno-unused-function -Wno-error=strict-prototypes -Wpointer-arith \
                   -fno-strict-aliasing -Wno-error=cpp -Wuninitialized -Wmaybe-uninitialized -Wno-unused-parameter -Wno-missing-field-initializers -Wtype-limits \
                   -Wsizeof-pointer-memaccess -Wno-format-nonliteral -Wno-cast-qual -Wunreachable-code -Wno-switch-default -Wreturn-type -Wmultichar -Wformat-security \
                   -Wno-ignored-qualifiers -Wno-error=pedantic -Wno-sign-compare -Wno-error=missing-prototypes -Wdouble-promotion -Wclobbered -Wdeprecated -Wempty-body \
                   -Wshift-negative-value -Wstack-usage=2048 -Wno-unused-value -std=gnu99
CFLAGS          ?= -O3 -g0 -I$(LVGL_DIR)/ $(WARNINGS)
LDFLAGS         ?= -lm

BIN             = x32ctrl
BUILD_DIR       = ../bin
BUILD_OBJ_DIR   = $(BUILD_DIR)/obj
BUILD_BIN_DIR   = $(BUILD_DIR)

prefix          ?= /usr
bindir          ?= $(prefix)/bin

# Collect source files recursively
CSRCS           := $(shell find \
                        -path './lv_port_linux/example' -prune -o \
                        -path './lv_port_linux/lvgl/demos' -prune -o \
                        -path './lv_port_linux/lvgl/examples' -prune -o \
                        -path './lv_port_linux/lvgl/tests' -prune -o \
			-type f -name '*.c' -not -path './lv_port_linux/src/main.c' -print)
CXXSRCS         := $(shell find \
                        -path './lv_port_linux/example' -prune -o \
                        -path './lv_port_linux/lvgl/demos' -prune -o \
                        -path './lv_port_linux/lvgl/examples' -prune -o \
                        -path './lv_port_linux/lvgl/tests' -prune -o \
			-type f -name '*.cpp' -not -path './lv_port_linux/src/main.c' -print)

all: copy default

# Include LVGL sources
include $(LVGL_DIR)/lvgl/lvgl.mk

OBJEXT          ?= .o

COBJS           = $(CSRCS:.c=$(OBJEXT))
CXXOBJS         = $(CXXSRCS:.cpp=$(OBJEXT))
AOBJS           = $(ASRCS:.S=$(OBJEXT))

SRCS            = $(ASRCS) $(CSRCS) $(CXXSRCS)
OBJS            = $(AOBJS) $(COBJS) $(CXXOBJS)
TARGET          = $(addprefix $(BUILD_OBJ_DIR)/, $(patsubst ./%, %, $(OBJS)))

$(BUILD_OBJ_DIR)/%.o: %.c lv_conf.h
	@mkdir -p $(dir $@)
	@$(CC)  $(CFLAGS) -c $< -o $@
	@echo "CC  $<"

$(BUILD_OBJ_DIR)/%.o: %.cpp lv_conf.h
	@mkdir -p $(dir $@)
	@$(CXX)  $(CFLAGS) -c $< -o $@
	@echo "CXX $<"

$(BUILD_OBJ_DIR)/%.o: %.S lv_conf.h
	@mkdir -p $(dir $@)
	@$(CC)  $(CFLAGS) -c $< -o $@
	@echo "AS  $<"

copy:
	# copy lv_conf.h to lv_port_linux to match expected structure of LVGL and its port
	cp lv_conf.h lv_port_linux/lv_conf.h

default: $(TARGET)
	@mkdir -p $(dir $(BUILD_BIN_DIR)/)
	$(CXX) -o $(BUILD_BIN_DIR)/$(BIN) $(TARGET) $(LDFLAGS)

clean:
	rm -rf $(BUILD_DIR)
