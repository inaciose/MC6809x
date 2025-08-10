# MC6809 SBC2

As ideias para este design são:  

- diminuir o tamanho necessário da ROM para 4K.  
- descodificar melhor o MC68B50. Só ocupar 2 endereços, que desejava serem os dois primeiros endereços dos ultimos 4K (sobropondo-se há rom que tem de ser desactivada).  
- preparar para um novo mapa de memoria que esteja de acordo com os requerimentos do flex, e tenha um espaço de 6K para o MC6847 (paged in/out).  
- fazer a maior parte do decoding com um GAL22V10D (e eventualmente um ou outro IC da serie 74Ls).  
- preparar para mudar para uma RAM de 64K, em vez da de 32K (com page in/out da ROM).  

Tenho que aprender a implemtar logica sequencial nos GAL.  


