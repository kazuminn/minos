CC =  x86_64-w64-mingw32-gcc
CFLAGS = -shared -nostdlib -mno-red-zone -fno-stack-protector -Wall \
         -e EfiMain -std=c++11

all: src/main.efi

%.efi: %.dll
	objcopy --target=efi-app-x86_64 src/main.o $@

%.dll: %.cpp
	$(CC) $(CFLAGS) -c -o $*.o $*.cpp
 
qemu: src/main.efi OVMF.fd image/EFI/BOOT/BOOTX64.EFI
	qemu-system-x86_64 -nographic -bios OVMF.fd -hda fat:image

image/EFI/BOOT/BOOTX64.EFI:
	mkdir -p image/EFI/BOOT
	ln -sf ../../../main.efi image/EFI/BOOT/BOOTX64.EFI

OVMF.fd:
	wget http://downloads.sourceforge.net/project/edk2/OVMF/OVMF-X64-r15214.zip
	unzip OVMF-X64-r15214.zip OVMF.fd

clean:
	rm -f src/main.efi
