CC =  clang
CFLAGS = -target x86_64-pc-win32-coff \
		-Iinclude \
		-fno-stack-protector -fshort-wchar -mno-red-zone -std=c++11 -Wall -Wpedantic -Wextra

all: BOOTX64.efi

OVMF.fd:
	wget http://downloads.sourceforge.net/project/edk2/OVMF/OVMF-X64-r15214.zip
	unzip OVMF-X64-r15214.zip OVMF.fd

clean:
	rm -f src/main.efi

os: 	
	make -C src os

BOOTX64.efi: 	
	make -C src 

qemu:
	make -C src qemu