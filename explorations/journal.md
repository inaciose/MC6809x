#1 2025-08

Inicio do projecto de construir um SBC baseado no MC6809, e com o MC6847.
Provavelmente irei começar por construir um SBC baseado no Grant's 6-chip 6809 computer:
http://searle.x10host.com/6809/Simple6809.html
Só depois de ter essa base estavel é que tentarei inserir o MC6847 no sistema.
Encomendei um MC6883 que é usado na integração do MC6847 com o MC6809, porque ambos concorrem pela utilização do bus para aceder á memória de video, e tal não pode acontecer ao mesmo temp.
Antes de chegar irei ver se consigo uma alternativa recorrendo a integrados comuns da serie 74, ou a um, ou mais GALs.
Por agora fico por uma recolha de datasheets e links relevantes.

#2
Tentativa moderadamente bem sucedida de melhorar o ruido gerado pelo relógio classico de cristal de 2pinos e o 74LS04.
Não vou usar neste projecto, pelo menos por agora.

Teste free run. Funcionou bem com os dois integrados. Consumo de 10mA e 11mA.

#3
Montei o circuito do SBC do Searl Grant, com a modificação do reset do Jeff Tranter, e com uma EPROM de 64K (27C512).
Quando Liguei não funcionou. A frustração do costume.

Como usei um MC6809, Enão o MC68B09, tinha A limitação da frequencia do relógio, este cpu tem como limite 1MHz, e como a frequencia do cristal é dividida por 4, então a frequencia maxima do cristal é de 4MZ. Decidi usar inicialmente um cristal de 3.6864MHZ e colocar o E no no RXCLK e TXCLK no MC68B50.
Não funcionou.

Ao princio achei que era um problema do sinal de relógio no RXCLK e TXCLK no MC68B50, por isso montei um relógio externo De cristal de 2pinos e o 74LS04 para ligar a esses pinos.
Não funcionou.

Depois pensei que como tinha usado uma ROM de 64K, e liguei os pinos A14 e A15 ao CPŨ, estava a ler no sitio errado da ROM, ou seja nos ultimos 16K e não nos primeiros. Coloquei os pinos A15 e A14 da ROM ligado á GND (e supostamente tinha os desligado do CPU). Assim seleciona o primeiro bloco.
Não funcionou.

Não funcionou pois o pino A14 continuava ligado ao CPU e por isso a linha A14 estava em curto. Resolvi o problema e o A14 e A15 da ROM ficaram os dois só ligados á GND.
Não funcionou.

Entretanto vi num comentário (https://jefftranter.blogspot.com/2019/01/a-6809-single-board-computer.html), que o SBC do Searl Grant funcionar com um MC6809, então o cristal a usar é o de 3.6864 MHz, mas que os condensadores ligados ao cristal não podem ser de 18pF mas sim de 24pF.

Troquei esses condensadores e com o RXCLK e TXCLK ligado ao E, tive sucesso.
Funcionou.

Consumo: 17 mA

Algumas considereraçoes. A forma como é feito o select do MC68B50 invalida o uso dos 16K existentes entre a RAM e A ROM. porque tem inumeras replicas.  

#4 Com aforma como é feito o select do MC68B50 invalida o uso dos 16K existentes entre a RAM e A ROM. porque tem inumeras replicas, tenho que procurar fazer o decoding completo para ocupar apenas 2 endereços.  
Portanto iniciei a execução faseada do SBC2 com isto em mente:  

- diminuir o tamanho necessário da ROM para 2K.  
- descodificar melhor o MC68B50. Só ocupar 2 endereços, que desejava serem os dois primeiros endereços dos ultimos 4K (sobropondo-se há rom que tem de ser desactivada).  
- preparar para um novo mapa de memoria que esteja de acordo com os requerimentos do flex, e tenha um espaço de 6K para o MC6847 (paged in/out).  
- fazer a maior parte do decoding com um GAL22V10D (e eventualmente um ou outro IC da serie 74Ls).  
- preparar para mudar para uma RAM de 64K, em vez da de 32K (com page in/out da ROM).  

O flex requer os seguintes espaços na memória  
0000-2FFF : 12K RAM (Flex utils)  
C000-DFFF : 8K RAM (Flex sys)  

O memory map que quero é o seguinte:  
0000-DFFF : 56K RAM  
E000-F7FF : 6K VRAM/RAM (VRAM paged in/out)  
F800-F801 : MC68B50 (2 bytes)  
F802-F802 : PAGE_CTL (1 byte)  
F803-F803 : FREE (1 byte)  
F804-FFFF : 2K ROM (ASSIST09) (RAM paged in/out)  

#5 Implementei parcialmente o que referi acima e não funcionou. Ainda não percebi porque. Vou reformular e simplificar, para  ver se faço passos menores.
Consumo: 21/22 mA (com o GAL22V10D e o 74LS10 adicionados).  

#6 Reformulei as equações do GAL1, pois estavam erradas, e tive que usar outro, o GAL2, para ter um OR(A2 a A10). Desta vez funcionou e pude retirar o 74LS00, que fornecia os sinais ROM_CS, Write e Read. Assim como ligar o CS0 e o CS1 do MC68B50 a VCC, e o CS2 ao GAL1. Ou seja o mapa de memória ficou como acima, mas ainda sem o page. A ROM passou a ser a ASTF800, que apenas tem o assis09, com o inicio empurado 4 byes para cima (tive que passar o hello para AST9, em vez de ASSIST09, para ganhar os bytes).
Depois de todas estas mudanças ficou a funcionar. Chamei-lhe SBC2a (versão temporária, no fim será o SBC2)
O proximo passo será remover o 74LS11, cujas saidas vão ser fornecidas pelo GAL2 (depois de reconfigurado), e melhorar a disposição dos fios que levam o bus de endereços até ele, já que irá necessitar de A2 a A15 (neste momento tem de A2 a A10).

#7 O 74LS11 foi removido, sendo a sua funcionalidade (1 and triplo completo, e um and triplo com dois inputs) passada para o GALv2.

#8 Foi trocada a memória de 32k por uma de 64K (se usarmos 2 memorias de 32k, teremos que adicionar um sinal de saida RAMHIGH_CS ao GAL1 e reformular como é que o RAM_CS é activado, tendo em conta que serão dois ICs de 32K. 
Funcionou, pelo que neste momento o SBC2 tem 56K RAM, 2K rom (com os seus primeiros 4 bytes para periféricos), e 6K de espaço reservado para a memória de video que ainda não foi implementada.  

#9 implementei a configuração do modo de video usada no circuito com o MC6847, https://github.com/inaciose/MC6847x/blob/main/explorations/test1/MC6847test1.pdf, em que os pinos dos dados e dos endereços foram ligados conjunto com uma memória de 4KB dual port IDT7134. Neste modo eram apenas usados os primeiros 512 Bytes. Correspondentes 32 caracteres por 16 linhas. Cada caracter da grelha pode ser modificado modificando o respectivo endereço da RAM.O inicio da VRAM é em C000, e no caso, com 4K o final é F000, mas com apenas 512 Bytes eficazes na alteração do ecrã. Para experimentar, no monitor entrar: M C000 e digitar HH (numero em hexadecimal) seguido de SPACE para avançar, ou ENTER para finalizar. É de notar que o código de caracteres do MC6847 não é o ascii. Como inicio de exploração, o A é 0x41.  
A situação permitia experimentar outros modos de video, no entanto decidi por evoluir para os 6K necesários para aceder ao modo de 256x192 px.  

#10 Para adicionar outra memória IDT7134, de modo a ter os 6K (2KB desaproveitados), também tenho de gerar dois vram_cs distintos, por isso não podia usar o vram_cs disponivel no GAL1. Pelo que o caminho foi fazer a configuração v3 do GAL2, que já tem todos os inputs necessários para gerar os sinais vram1_cs e vram2_cs. Isto para o lado do bus geral, para o lado do bus do MC6847, o CS das duas memórias são A12 e not(A12). A coniguração do modo de video teve ser alterada (trocar ligações a terra para vcc).  
Cada ponto da grelha de 256*192, está representado num bit dentro de um byte, pelo que quando se modifica um byte dentro da gama C000 a F7FF, pode-se modificar oito pontos seguidos da mesma linha.   
Para testar o funcionanento das zonas da memória de videlo, no monitor entrar: M C000 (para o inicio da VRAM, no primeiro IC), e M F000 (para o inicio dos ultimos 2KB da VRAM, no segundo IC).  
Funcionou bem. É o MC6809_SBC3, com 2K ROM, 56K RAM, 6K VRAM, com saida de video composto em modo gráfico 256x192x2.  
Eventualmente o proximo passo fosse implementar a logica para permitir alterar o modo de video por programação. Existem dois endereços disponiveis, pelo que é possivel usar um deles para defenir o valor de cada um dos 8 flip flops, do 74LS273, formando assim a possibilidade de controlar qual o modo de video eficaz. Estou a descartar o uso de rom externa para ter caracteres mais adequados.  
Também há a possibilidade de acrescentar um teclado, mas creio que ficarei por aqui.
