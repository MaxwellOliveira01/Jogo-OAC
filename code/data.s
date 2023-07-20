
# Importante: Lembrar de manter a memória alinhada

CharPos:	.half 16, 16		# x, y
OldCharPos: .half 16, 16		# x, y

CorFundo:	.word 10			# marrom aleatorio

Camera:		.word 0			# posição inicial da camera (ultima coluna do bitmap)

CrashsDoRars:	.word 7			# Quantas vezes o RARS crashou/bugou durante o desenvolvimento
