
# Importante: Lembrar de manter a memória alinhada

CharPos:		.half 16, 16		# x, y
OldCharPos: 	.half 16, 16		# x, y
CharDir:		.word 1				# 0: Esquerda, 1: Direita 

Camera:			.word 0				# posição inicial da camera (ultima coluna do bitmap)

CrashsDoRars:	.word 7				# Quantas vezes o RARS crashou/bugou durante o desenvolvimento
