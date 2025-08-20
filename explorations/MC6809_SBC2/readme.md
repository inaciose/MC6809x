# MC6809 SBC2

As ideias para este design são:  

- diminuir o tamanho necessário da ROM para 4K.  (feito)  
- descodificar melhor o MC68B50. Só ocupar 2 endereços, que desejava serem os dois primeiros endereços dos ultimos 4K (sobropondo-se há rom que tem de ser desactivada).  (feito)   
- preparar para um novo mapa de memoria que esteja de acordo com os requerimentos do flex, e tenha um espaço de 6K para o MC6847 (paged in/out).   (semi feito, falta o page in/out, o que significa que vou ter que aprender a fazer latches ou flip flops nos gals)  
- fazer a maior parte do decoding com um GAL22V10D (e eventualmente um ou outro IC da serie 74Ls).  (foi neessário 2 x GAL22V10D e 1 x 74LS11, é provavel mais tarde colocar o que está no 74LS11, no GAL2)
- preparar para mudar para uma RAM de 64K, em vez da de 32K (com page in/out da ROM).  (por fazer, terei que deixar de usar o 74LS00, e passar tudo para o GAL1, que supostamente já produz todos os sinais que o LS00 produz, ROM_CS, ROMeRAM_OE, RAM_WE. O RAM_CS é actualmente A15, e não vem do 74LS)

Tenho que aprender a implemtar logica sequencial nos GAL.  

Neste momento com 8 ICs, o consumo é de 260mA.

Reparei que tinha desligado a GND da ROM, mas no entanto a ROM funcionava. Talvez porque tenho o A15 e o A14 ligado á terra. (por falar nisso, deveria colocar uns jumpers para selecionar várias secçoes de 2k diferentes da ROM. Talvez com monitores diferentes, ou com o minimo de código necessário para fazer o boot de um 'cf card' ou de um 'sd card' antes de o ligar).

O 74LS00 foi removido. Tudo a funcionar. Chamei-lhe SBC2a (versão temporária, no fim será o SBC2)
O proximo passo será remover o 74LS11, cujas saidas vão ser fornecidas pelo GAL2 (depois de reconfigurado), e melhorar a disposição dos fios que levam o bus de endereços até ele, já que irá necessitar de A2 a A15 (neste momento tem de A2 a A10).

O 74LS11 foi removido, e já troquei o IC da RAM de 32K por um de 64K (W24512), é compativel com os pinos, e basta acrescentar o A15 e deslocar a alimentação. Para podermos usar dois ICs de 32K teremos que adicionar um sinal de saida RAMHIGH_CS ao GAL1 e reformular como é que o RAM_CS é activado, tendo em conta que serão dois ICs de 32K. Como eu tinha um de 64K disponivel, não foi necessário. Talvez um dia faça essa verssão.

Portanto o MC6809_SBC2 está pronto, e esteve num teste de 24H sempre a funcionar.

O memory map que quero é o seguinte:  
0000-DFFF : 56K RAM  
E000-F7FF : 6K VRAM/RAM (VRAM paged in/out)  
F800-F801 : MC68B50 (2 bytes)  
F802-F802 : PAGE_CTL (1 byte)  
F803-F803 : FREE (1 byte)  
F804-FFFF : 2K ROM (ASSIST09) (RAM paged in/out)  


Pelo que percebi está de acordo com os requisitos de RAM do flex.  
0000-2FFF : 12K RAM (Flex utils)  
C000-DFFF : 8K RAM (Flex sys)  

A porta serie é 57600 baud, 8N1.

E está preparado para ser expandido com video, e eventualmente teclado e um RTC.