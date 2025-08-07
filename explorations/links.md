# 1 Searl Grant, the base work, credits to him. 
MC68B09, 32K RAM, 16K ROM, MC68B50 
ROM: BASIC (or custom) 
http://searle.x10host.com/6809/Simple6809.html 
MMAP 
0000 - 7FFF RAM 32K 
8000 - 9FFF not used 8K 
A000 - BFFF MC68B50 ACIA 8K (we need a better decoding) 
C000 - FFFF ROM 16K 

# 2 Jeff Tranter, the same as Searl Grant with other reset circuit. 
MC68B09, 32K RAM, 16K ROM, MC68B50 
ROM ASSIST9 + BASIC, etc (or custom) 
https://jefftranter.blogspot.com/2019/01/a-6809-single-board-computer.html 
https://github.com/jefftranter/6809 
MMAP is the same as Searl 

# 2 Laurent 
MC68B09, 32K RAM, 16K ROM, MC68B50, MC6840, MC6821, WD1770, MK4BT12 
ROM: ASSIST9, flex?  (or custom) 
https://www.64kforanybody.com/flex1.html 
https://github.com/laurent-fr/LFlex21 
MMAP 
0000-E7FF : RAM 58K 
E800-E807 : PTM (MC6840) 8B 
E808-E80F : ACIA (MC68B50) 8B 
E810-E817 : PIA (MC6821) 8B 
E818-E81F : FLOPPY (WD1770) 8B 
E820-E839 : Free 10B 
E840-EFF7 : NVRAM (MK4BT12) 1976B 
EFF8-EFFF : RTC (MK4BT12) 8B 
F000-FFFF : ROM 4K 


https://hackaday.io/project/176383-6809-sbc



https://hackaday.com/2024/12/06/the-6809-8-bit-microcomputer-a-father-son-odyssey/



https://hackaday.io/project/168536/


https://www.64kforanybody.com/flex1.html
https://github.com/laurent-fr/LFlex21

https://github.com/jbevren/6809v2


https://www.aslak.net/index.php/2013/04/01/6809-led-output-test/


https://hackaday.io/project/164305-roscom68k/log/163910-prepping-for-the-mc68901-and-nailing-reliability

MC6821 PIA Peripheral Interface Adapter
MC6840 PTM programable Timer Module
MC6850 ACIA
WD1770 Floppy controller

