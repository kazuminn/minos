CC =  clang
CFLAGS = -target x86_64-pc-win32-coff \
		-Iinclude \
		-fno-stack-protector -fshort-wchar -mno-red-zone -std=c++11 -Wall -Wpedantic -Wextra

all: BOOTX64.efi

BOOTX64.efi: BOOTX64.dll
	lld-link-9 main.o -subsystem:efi_application -nodefaultlib -dll \
                -entry:EfiMain main.o -out:../image/EFI/BOOT/BOOTX64.EFI

BOOTX64.dll:
	$(CC) $(CFLAGS) -c -o main.o main.cpp

os: osmain
	ld.lld-9 -o os.ELF -e KernelEntry osmain.o

osmain:
	$(CC) -c -o osmain.o osmain.cpp
 
clean:
	rm -f src/main.efi

qemu: BOOTX64.efi OVMF.fd image/EFI/BOOT/BOOTX64.EFI
	qemu-system-x86_64 -nographic -bios OVMF.fd -drive format=raw,file=fat:rw:../image

image/EFI/BOOT/BOOTX64.EFI:
	mkdir -p image/EFI/BOOT
	ln -sf efimain.efi image/EFI/BOOT/BOOTx64.EFI

OVMF.fd:
	wget http://downloads.sourceforge.net/project/edk2/OVMF/OVMF-X64-r15214.zip
	unzip OVMF-X64-r15214.zip OVMF.fd