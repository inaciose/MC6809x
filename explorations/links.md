# 1 - Searl Grant, the base work, credits to him. 
MC68B09, 32K RAM, 16K ROM, MC68B50  
ROM: BASIC (or custom) 

http://searle.x10host.com/6809/Simple6809.html 

MMAP  
0000 - 7FFF : RAM 32K  
8000 - 9FFF : not used 8K  
A000 - BFFF : MC68B50 ACIA 8K (we need a better decoding)  
C000 - FFFF : ROM 16K 

# 2 - Jeff Tranter, the same as Searl Grant with other reset circuit. 

MC68B09, 32K RAM, 16K ROM, MC68B50  
ROM ASSIST9 + BASIC, etc (or custom)  
https://jefftranter.blogspot.com/2019/01/a-6809-single-board-computer.html  
https://github.com/jefftranter/6809  
MMAP is the same as Searl  

# 2 - Laurent 
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

# 3 - jbevren 
MC6809E, 128K RAM, 8K ROM, MC68681, 74HC244 SDcard  
FLEX or OS-9 Level I  
https://jbevren.wordpress.com/2018/09/22/designing-a-6809-sbc/  
https://github.com/jbevren/6809v2  

0000-DFFF : RAM 56K , bankswitched via GPIO  
E000-FEFF : ROM or RAM 7936B, controlled via GPIO (ROMON=high) or System RAM(ROMON=low)  
FF00-FF0F : 68681 DUART (see below for I/O definitions)  
FF10-FFDF	reserved: Don't use  
FFF0-FFFF : ROM or RAM 16B, controlled via GPIO  

DUART I/O Map:  
IP0		CTS port A  
IP1		CTS port B  
IP2		DCD port A (not routed)  
IP3		DCD port B (not routed)  
IP4		n/c  
IP5		SD Data input	Input from Micro SD  

OP0		RTS port A  
OP1		RTS port B  
OP2		RAM A16		A16 to RAM  
OP3		RAM A17		A17 to RAM (128k has CE2 here)  
OP4		ROMON		High enables the 2764 eprom  
OP5		SDCK		Clock output to Micro SD  
OP6		SDDO		Data output to Micro SD  
OP7		SDCS		Chip select output to Micro SD  
		NOTE: The 68681 sets all outputs high on reset  
		NOTE: The 68681 inverts its output port bits  


# 4 - hackaday 6809-sbc
MC6809E, 128K RAM, 8K ROM, MC68681, MC6859
Flex from CF card
https://hackaday.io/project/176383-6809-sbc
https://github.com/valgamaa/6809-SBC  

MMAP  
0000-7FFF RAM 32K  
8000-CFFF  
E000-EFFF 4K mapped ram / ROM at startup  
F000-F7FF I/O 2K  

# to check
https://hackaday.com/2024/12/06/the-6809-8-bit-microcomputer-a-father-son-odyssey/

https://hackaday.io/project/168536/

https://www.aslak.net/index.php/2013/04/01/6809-led-output-test/  


# FLEX  
The FLEX disk operating system itself resides in the range of $C000 to
$DFFF. This means you will need 8K of memory starting at $C000. You
should be certain your particular system can accept memory in this
region.  
You must also have “User Memory" (RAM) starting at location $0000 and
running continuously up from there. The more user memory you have in
your system the better off you will be. This is because you will be
able to run larger programs and because software which works with files
that are larger than memory can hold (such as the editor or sort/merge)
will operate more efficiently and quickly. Although FLEX resides at
$C000, certain of its commands utilize the lower end of this user RAM
space. A minimum of 12K of RAM is required for such purposes.  

MMAP Flex memory requirements  
0000-2FFF : RAM 12K required for flex utilities  
3000-BFFF : available - RAM/IO 36K  
C000-DFFF : RAM 8K - required for flex system  
E000-FFFF : available - RAM/ROM/IO 8K  

# ICs  
MC6821 PIA Peripheral Interface Adapter  
MC6840 PTM programable Timer Module  
MC6850 ACIA  
MC6859 Data Security Device  
WD1770 Floppy controller  
RTC72421 RTC

# Other  


https://hackaday.io/project/164305-roscom68k/log/163910-prepping-for-the-mc68901-and-nailing-reliability  


Try the Flex memory requirements with W24512 64K sram  
0000-2FFF : RAM 12K required for flex utilities  
3000-BFFF : available - RAM/IO 36K  
C000-DFFF : RAM 8K - required for flex system   
E000-FFFF : available - RAM/ROM/IO 8K  (first 16 bytes for IO, first 2 for acia)  

Total 56K ram at boot  
Total 64K ram with ROM page out, may be copied to ram at begin  

Tentar como o hackaday 6809-sbc (4). No boot as escritas na area da ROM vão para a memoria RAM, e as leituras para a ROM. Se se copiar o conteudo da ROM para a RAM, depois pode se fazer o page out da ROM, caso seja necessário, e voltar a fazer o page in quando necessário outra vez.  

