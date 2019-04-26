# Proj-PLP-2019.1-Shogi

Projeto de Paradigmas de Linguagens de Programação - 2019.1

Grupo:
• Lukas Soares do Nascimento
• Aislan Jefferson de Souza Brito
• Felipe Emanuel de Farias Nunes
• Matheus Alves do Nascimento
• Pedro Paulo Freire Oliveira
• Jonathan Lucas Feitosa de Morais

Proposta:

Nara Shogi

O projeto consiste em implementar o jogo de tabuleiro Shogi. É a versão japonesa do xadrez. O objetivo do jogo é o mesmo do xadrez ocidental, mas mudam-se as peças e o tabuleiro. Vence o jogo quem capturar o rei adversário.

Funcionalidades iniciais:

Menu principal: recebe comando para iniciar um jogo
Menu de dificuldade: permite os jogadores escolherem o tabuleiro que querem jogar: Iniciante (4 x 3), Tradicional (9 x9) e Mestre (13 x 13)
Permite que o jogador 1 e o jogador 2 ponham seus nomes, respectivamente

Funcionalidades em jogo:

O tabuleiro do jogo tradicional consiste em uma matriz de 9 x 9, onde i representa as colunas e j representa as linhas.
Os jogadores devem escolher uma de suas peças no tabuleiro e serem informados das possíveis posições no tabuleiro para onde a peça pode se mover.
Após o jogador digitar e submeter para onde quer que sua peça se mova, caso seja um movimento válido, já informado anteriormente, a peça mudará para a posição informada.
Caso a peça vá para um local onde existe uma peça do adversário, a peça do adversário é capturada e sai do tabuleiro. 



Cada tipo de peça possui seus movimentos próprios, que podem ser implementados com cálculos a partir da sua posição atual. As 20 peças do jogo são as seguintes:
1 rei
(Move-se 1 casa em qualquer direção)
2 generais de ouro
(1 casa na vertical, horizontal ou diagonalmente para frente. Não pode movimentar-se diagonalmente para trás)
2 generais de prata 
(1 casa para frente ou diagonal frontal, uma casa em diagonal para trás)
2 cavalos
(Uma casa para frente e uma casa diagonal para frente. Não pode recuar. )
2 lanceiros 
(Move-se por qualquer número de casas livres para frente. Não pode recuar.)
1 bispo
(Pode andar por qualquer número de casas livres nas diagonais)
1 torre 
(Anda por qualquer número de casas livres verticalmente ou horizontalmente)
9 peões
(Move-se apenas uma casa para frente)

