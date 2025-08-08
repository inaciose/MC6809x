all: assist09-orig.s19 assist09-6850.s19 assist09-6850.hex assist09-6850.bin

assist09-orig.s19: assist09-orig.asm
	as9 assist09-orig.asm -l s19 now

assist09-6522.s19: assist09-6522.asm
	as9 assist09-6522.asm -l s19 now

assist09-6850.s19: assist09-6850.asm
	as9 assist09-6850.asm -l s19 now

assist09-6850.hex: assist09-6850.s19
	srec_cat assist09-6850.s19 -Motorola -crop 0xc000 0x10000 -output assist09-6850.hex -Intel

assist09-6850.bin: assist09-6850.s19
	srec_cat assist09-6850.s19 -Motorola --crop 0xc000 0x10000 -offset -0xc000 -output assist09-6850.bin -Binary

clean:
	$(RM) assist09-orig.s19 assist09-orig.lst
	$(RM) assist09-6522.s19 assist09-6522.lst
	$(RM) assist09-6850.s19 assist09-6850.lst
	$(RM) assist09-6850.s19 assist09-6850.hex
	$(RM) assist09-6850.s19 assist09-6850.bin

distclean: clean
