CXXFLAGS = -g -Wall -fmessage-length=0

SOURCES = *.S

LIBS =

TARGET = miniloader.elf

$(TARGET):      $(SOURCES)
	arm-none-eabi-gcc $(CXXFLAGS) -o $(TARGET) $(SOURCES) $(LIBS) -T miniloader.ld -nostartfiles -nostdlib -Wl,-Map,miniloader.map,--cref,-n
	arm-none-eabi-objcopy -O binary miniloader.elf miniloader.bin

all:    $(TARGET)

clean:
	cs-rm -f $(TARGET)
	cs-rm -f miniloader.bin

