
# Importante: Lembrar de manter a memória alinhada

CharPos:		.half 16, 192		# x, y
OldCharPos: 	.half 16, 192		# x, y
CharDir:		.word 1				# 0: Esquerda, 1: Direita 

HistorySleepTimeInMs: .word 5000	# Segundos entre as cenas de dialogo da historia

Camera:			.word 0				# posição inicial da camera (ultima coluna do bitmap)

CrashsDoRars:	.word 7				# Quantas vezes o RARS crashou/bugou durante o desenvolvimento


cntMovesX: 		.word 0				# Quantos movimentos no eixo x já foram feitos
									# Isso vai ser util pra saber qual sprite do personagem usar
									
# Jumping section

Jumping:		.word 0				# Booleano pra afirmar se o jogador está 
									# pulando ou não
									
JumpSleepTime:	.word 500			# Tempo entre as chamadas do jump

LastJumpUpdate:	.word 0				# Momento da ultima ação de jump

JumpHeight:		.word 40			# altura máxima do pulo
JumpCurrentHeight: .word 0			# altura que o pulo atual já subiu


# MIDI section

NextNote:	.word 0					# Proxima nota que está será tocada
PlayThCurrentNoteUntil:	.word 0		# Até quando a nota atual deve ser tocada?
MuteMidi:	.word 0					# Booleano para parar de tocar as notas
