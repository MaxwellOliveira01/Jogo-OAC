.data

	LifeStr: .string "Vidas:"

.text

LifeDisplay:
	SaveRegisters()
	
	la a0, LifeStr
	li a1, 0
	li a2, 0
	li a3, 255
	li a4, 0
	li a7, 104 			# print string na tela
	ecall
	
	la a0, Lifes
	lw a0, 0(a0)
	li a1, 48
	li a2, 0
	li a3, 255
	li a4, 0
	li a7, 101			# print int na tela
	ecall
	
	la a0, LifeStr
	li a1, 0
	li a2, 0
	li a3, 255
	li a4, 1
	li a7, 104 			# print string na tela
	ecall
	
	la a0, Lifes
	lw a0, 0(a0)
	li a1, 48
	li a2, 0
	li a3, 255
	li a4, 1
	li a7, 101			# print int na tela
	ecall
	
	LoadRegisters()
	ret


# Se a posição que o personagem é de dano
# (olhar no hitbox)
# então subtrai uma vida
# e manda ele de volta pro começo
# resetar as variaveis!!!!!!
# codigo parecido com o do moveChar
# mexer aqui tem que mexer la

CheckDamage:
	SaveRegisters()
	
	la t0, CharPos						# le o endereço das coordenadas
	lh t1, 0(t0)						# le o x atual
	lh t2, 2(t0)						# le o y atual
	
	la t3, Camera						# le o endereço da camera
	lw t3, 0(t3)						# le a camera
	add t1, t1, t3						# adiciona o offset da camera na coord x
	
	# Testando o superior esquerdo do personagem
	la s0, mapHitBox					# le o endereço do hitbox
	lw s1, 0(s0)						# le a quantidade de colunas do hitbox
	lw s2, 4(s0) 						# le a quantidade de linhas do hitbox
	addi s0, s0, 8						# Ignora a largura/comprimento no inicio do hitbox
	mul s3, t2, s1						# calcula y * colunas_hitbox
	add s0, s0, s3						# move o ponteiro do mapa para a linha correta
	add s0, s0, t1						# move o ponteiro do mapa para a coluna correta
	lb s4, 0(s0)						# lê a cor neste ponto do mapa
	li t6, 7							# cor de damage
	beq s4, t6, DamageFounded			# testa se deu dano
	
	# Testa o ponto inferior esquerdo
	la t0, CharDireita					# pega um sprite qualquer
	lw t3, 4(t0)						# pega a altura do personagem
	add t2, t2, t3						# adiciona a altura em y
	addi t2, t2, -1						# magia antiga
	
	la s0, mapHitBox					# le o endereço do hitbox
	lw s1, 0(s0)						# le a quantidade de colunas do hitbox
	lw s2, 4(s0) 						# le a quantidade de linhas do hitbox
	addi s0, s0, 8						# Ignora a largura/comprimento no inicio do hitbox
	mul s3, t2, s1						# calcula y * colunas_hitbox
	add s0, s0, s3						# move o ponteiro do mapa para a linha correta
	add s0, s0, t1						# move o ponteiro do mapa para a coluna correta
	li t6, 7							# cor de damage
	beq s4, t6, DamageFounded			# testa se deu dano
	
	# Testa o ponto inferior direito
	la t0, CharDireita					# pega um sprite qualquer
	lw t3, 0(t0)						# pega a largura do personagem
	add t1, t1, t3						# adiciona a largura em x
	addi t1, t1, -1						# magia antiga
	
	la s0, mapHitBox					# le o endereço do hitbox
	lw s1, 0(s0)						# le a quantidade de colunas do hitbox
	lw s2, 4(s0) 						# le a quantidade de linhas do hitbox
	addi s0, s0, 8						# Ignora a largura/comprimento no inicio do hitbox
	mul s3, t2, s1						# calcula y * colunas_hitbox
	add s0, s0, s3						# move o ponteiro do mapa para a linha correta
	add s0, s0, t1						# move o ponteiro do mapa para a coluna correta
	li t6, 7							# cor de damage
	beq s4, t6, DamageFounded			# testa se deu dano
	
	# Testa o ponto superior direito
	la t0, CharDireita					# pega um sprite qualquer
	lw t3, 4(t0)						# pega a altura do personagem
	sub t2, t2, t3						# adiciona a altura em y
	addi t2, t2, 1						# magia antiga
	
	la s0, mapHitBox					# le o endereço do hitbox
	lw s1, 0(s0)						# le a quantidade de colunas do hitbox
	lw s2, 4(s0) 						# le a quantidade de linhas do hitbox
	addi s0, s0, 8						# Ignora a largura/comprimento no inicio do hitbox
	mul s3, t2, s1						# calcula y * colunas_hitbox
	add s0, s0, s3						# move o ponteiro do mapa para a linha correta
	add s0, s0, t1						# move o ponteiro do mapa para a coluna correta
	li t6, 7							# cor de damage
	beq s4, t6, DamageFounded			# testa se deu dano
	
	
CheckDamageReturn:
	LoadRegisters()
	ret











DamageFounded:
	
	# O personagem tomou dano,
	# Checar as vidas dele
	
	
	la t0, Lifes						# pega as vidas atuais
	lw t1, 0(t0)
	addi t1, t1, -1
	sw t1, 0(t0)
	
	bge zero, t1, GameOver				# verifica se o jogador perdeu

	# Reseta as variaveis
	
	la t0, CharPosDefault
	la t1, CharPos
	lw t2, 0(t0)
	sw t2, 0(t1)
	
	la t0, OldCharPosDefault
	la t1, OldCharPos
	lw t2, 0(t0)
	sw t2, 0(t1)
	
	la t0, CharDirDefault
	la t1, CharDir
	lw t2, 0(t0)
	sw t2, 0(t1)
	
	la t0, CameraDefault
	la t1, Camera
	lw t2, 0(t0)
	sw t2, 0(t1)
	
	la t0, cntMovesXDefault
	la t1, cntMovesX
	lw t2, 0(t0)
	sw t2, 0(t1)
	
	la t0, JumpingDefault
	la t1, Jumping
	lw t2, 0(t0)
	sw t2, 0(t1)
	
	la t0, LastJumpUpdateTimeDefault
	la t1, LastJumpUpdateTime
	lw t2, 0(t0)
	sw t2, 0(t1)
	
	la t0, JumpCurrentHeightDefault
	la t1, JumpCurrentHeight
	lw t2, 0(t0)
	sw t2, 0(t1)
	
	la t0, NextNoteDefault
	la t1, NextNote
	lw t2, 0(t0)
	sw t2, 0(t1)
	
	la t0, PlayThCurrentNoteUntilDefault
	la t1, PlayThCurrentNoteUntil
	lw t2, 0(t0)
	sw t2, 0(t1)
	
	call Setup
	
	# Desenha o mapa inicial 'map'
	
	j CheckDamageReturn
