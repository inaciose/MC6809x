# Single Step on MC6809

Uma das coisas que gosto de poder fazer quando as coisas não funcionam, e nem sequer tenho acesso a uma uart funcional, é poder ir instrução a instrucão (pelo menos aquelas que acedem ao espaço á memória ou periféricos), e ir observando os sinais dos barramentos de endereços dados e controlo em leds.

Numa pesquisa na net não encontrei nenhum circuito ou ideia de como o fazer. Portanto comecei a pensar no assunto e cheguei a estas conclusões.

Usar o sinal HALT_ para controlar a execução passo a passo. Num sistema normal o HALT deve estar normalmente high, e portanto o cpu nunca para.
A ideia é ter um jumper para colocar o HALT normalmente baixo, e só quando clicamos num botão é que ele fica high durante um clico de relógio e avança na na execução da instrução. Como, supostamente o halt só fica high um ciclo de relogio, e o cpu só para no final da instrução quando verificar que o sinal halt está low (pois só ficou um ciclo de relogio high), então pára outra vez até se voltar a clica no botão. 

Lembrei-me do circuito de dtack que usei no DBC com MC68010, e achei que faz exactamente a mesma coisa mas ao contrario.
O comportamento desse circuito está visivel nas imagens 68Kdtack*. 

Sendo, assim á partida, penso que basta colocar um inversor (74LS04) na saida.

TODO
