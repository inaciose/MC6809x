Circuito de relógio base. Que alterei como tentativa de melhorar o ruido.
Creio que foi bem sucedido. Não resolveu completamente, mas melhorou. O efeito é visivel na comparação das imagens capturadas. Em destaque as:

vcc_gnd_old_800ns.jpg
vcc_gnd_new_800ns.jpg

Tenho duvidas sobre os valores do 5uH do indutor e 10n do condensador adicionados.
Experimentei com um indutor de 10uH e pareceu-me pior. Aparecia uma queda de tensão enorme, a espaços de tempo imprevisiveis.

Estava a pensar experimentar usar o relógio com este circuito. A saida no pino 4 é o sinal de relógio que vai ligar ao EXTAL no MC6809, com o XTAL a GND, ainda aos RXCLK e TXCLK do MC68B50. Mas abandonei a ideia. Vou usar o esquema do searl grant e usar os dois pinos XTAL e EXTAL no MC6809, para gerar o relógio, e usar a versão dividida por 4 (0.9216 MHZ), disponivel no pino E, para RXCLK e TXCLK.

NOTA: para converter ficheiros de bmp para jpg, instalar o imagemagick:

sudo apt install imagemagick

e usar o comando: 

mogrify -format jpg *.bmp
