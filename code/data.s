
# Importante: Lembrar de manter a memória alinhada

CharPos:		.half 16, 192		# x, y
OldCharPos: 	.half 16, 192		# x, y
CharDir:		.word 1				# 0: Esquerda, 1: Direita 

HistorySleepTimeInMs: .word 5000	# Segundos entre as cenas de dialogo da historia

Camera:			.word 0				# posição inicial da camera (ultima coluna do bitmap)

CrashsDoRars:	.word 7				# Quantas vezes o RARS crashou/bugou durante o desenvolvimento


cntMovesX: 		.word 0				# Quantos movimentos no eixo x já foram feitos
									# Isso vai ser util pra saber qual sprite do personagem usar