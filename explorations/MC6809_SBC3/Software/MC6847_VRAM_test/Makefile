all: mc6847test1.s19 mc6847test1.hex mc6847test1.bin

mc6847test1.s19: mc6847test1.asm
	as9 mc6847test1.asm -l s19 now

mc6847test1.hex: mc6847test1.s19
	srec_cat mc6847test1.s19 -Motorola -crop 0xc000 0x10000 -output mc6847test1.hex -Intel

mc6847test1.bin: mc6847test1.s19
	srec_cat mc6847test1.s19 -Motorola --crop 0xc000 0x10000 -offset -0xc000 -output mc6847test1.bin -Binary

clean:
	$(RM) mc6847test1.s19 mc6847test1.lst
	$(RM) mc6847test1.s19 mc6847test1.hex
	$(RM) mc6847test1.s19 mc6847test1.bin

distclean: clean
