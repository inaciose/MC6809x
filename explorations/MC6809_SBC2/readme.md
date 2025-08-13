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
