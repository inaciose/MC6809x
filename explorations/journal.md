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

#4 Algumas considereraçoes. A forma como é feito o select do MC68B50 invalida o uso dos 16K existentes entre a RAM e A ROM. porque tem inumeras replicas.



