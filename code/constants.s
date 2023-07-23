# Importante: Lembrar de manter a memória alinhada

LarguraTela:		.word 320

CharPosDefault:		.half 16, 192			# x, y
OldCharPosDefault: 	.half 16, 192			# x, y
CharDirDefault:		.word 1					# 0: Esquerda, 1: Direita 

CameraDefault:			.word 0				# posição inicial da camera (ultima coluna do bitmap)

cntMovesXDefault: 		.word 0				# Quantos movimentos no eixo x já foram feitos
											# Isso vai ser util pra saber qual sprite do personagem usar													
	
# Jumping section

JumpingDefault:					.word 0		# Booleano pra afirmar se o jogador está 
											# pulando ou não
LastJumpUpdateTimeDefault:		.word 0		# Ultima vez que o pulo foi atualizado
JumpCurrentHeightDefault: 		.word 0		# altura que o pulo atual já subiu


# MIDI section

NextNoteDefault:	.word 0					# Proxima nota que está será tocada
PlayThCurrentNoteUntilDefault:	.word 0		# Até quando a nota atual deve ser tocada?
