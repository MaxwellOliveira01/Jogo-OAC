Jump:
	SaveRegisters()
	
	# Ideia: A todo momento, puxa o cara para baixo
	# Se ele apertar para pular, então não puxa para baixo
	# Puxa para cima até o limite do pulo e dps deixa ir descendo normalmente
	# Quando descer tudo, seta a variavel para 0
	
	# Checa se já está na hora de fazer o pulo dnv
	li a7, 30								# ecall de time
	ecall
	
	la t0, LastJumpUpdateTime				
	lw t0, 0(t0)							# Ultima vez que o pulo 
											# foi atualizado
	la t1, JumpSleepTime					# pega o 'clock' do jump
	lw t1, 0(t1)							
	
	add t0, t0, t1							# adiciona na ultima vez que foi atualizado
	
	bleu a0, t0, JumpReturn					# Se o tempo atual é menor que
											# ultimoUpdate+tempoDeSleep
											# então não faz nada
	
	la t0, Jumping
	lw t0, 0(t0)
	
	beq t0, zero, CharIsNotJumping
	j CharIsJumping
	
JumpUpdateTime:

	# atualizaa o tempo de LastJumpUpdateTime
	
	li a7, 30								# ecall de tempo
	ecall
	
	la t0, LastJumpUpdateTime
	sw a0, 0(t0)							# salva o tempo atual na memoria
	
JumpReturn:
	
	
	LoadRegisters()
	
	ret
	
	
	
	
	
	
	
	
CharIsJumping:

	# Se o personagem bater a cabeça durante o pulo
	# então o pulo deve ser cancelado
	
	j CheckIfCharWillHitWall

CharIsJumpingContinue:

	la t0, JumpHeightPerClock			# pega o quanto o  y deve mudar
	lw t0, 0(t0) 						# durante o pulo
	sub t0, zero, t0					# como aqui é salto, entao deixa negativo
	
	li a0, 0							# não quero mover em x
	mv a1, t0							# mover -jumpHeightPerClock em y
	la a2, CharDir
	lw a2, 0(a2)						# a direção não modifica
	
	call MoveChar						# tenta mover
	
	la t0, JumpHeightPerClock			# pega o quanto o y deve mudar
	lw t0, 0(t0)						# durante o pulo
	
	la t1, JumpCurrentHeight			# pega o tamanho do pulo atual
	lw t2, 0(t1)
	
	add t2, t2, t0						# adiciona o quanto ele se moveu
										# ao pulo atual
										
	sw t2, 0(t1)						# salva a nova altura do pulo
	
	la t0, JumpHeight					# pega a altura maxima do pulo
	lw t0, 0(t0)

	# if tamanho-salto-atual < maximo-tamanho-salto
	# continua pulando
	# else, para de pular
	
	blt t2, t0, CharIsJumpingReturn

CharIsJumpingResetJump:
			
	# Resetar as variaveis de pulo
	
	la t0, Jumping
	sw zero, 0(t0)
	
	la t0, JumpCurrentHeight
	sw zero, 0(t0)
	
CharIsJumpingReturn:

	j JumpUpdateTime
	



# codigo mt parecido com o do movechar
# se mudar aqui talvez tenha que mudar la
CheckIfCharWillHitWall:
	
	# Checa tem uma parede logo a cima da 
	# cabeça do personagem
		
	la t0, CharPos						# le o endereço das coordenadas
	lh t1, 0(t0)						# le o x atual
	lh t2, 2(t0)						# le o y atual
		
	addi t2, t2, -1						# olha pro tile acima
	
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
	beq s4, zero, CharIsJumpingResetJump		# é parede
	
	# Testa o ponto superior direito
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
	lb s4, 0(s0)						# lê a cor neste ponto do mapa
	beq s4, zero, CharIsJumpingResetJump		# é parede

	j CharIsJumpingContinue











CharIsNotJumping:

	# Adiciona gravidade ao jogo
	# Puxa o personagem para baixo
	# Exceto se ele estiver acima de um 'chão'
	
	# if mapa[x][y-1] == parede: retorna
	# se não, y--;
	
	la t0, JumpHeightPerClock
	lw t0, 0(t0)						# pega em quanto o y do jogador deve mudar
	
	li a0, 0							# não quero mover em x
	mv a1, t0							# mover jumpHeightPerClock em y
	la a2, CharDir
	lw a2, 0(a2)						# a direção não modifica
	
	call MoveChar						# tenta mover o personagem

	# Retorna a execução para o Jumping
	j JumpUpdateTime
	
	
	
	
	
	
	
	
	
	
	
	
StartJump:

	# Impedir que o jogador faça um pulo
	# sem estar com os pes no chao
	# ele n é um passaro pra estar voando
	
	j CheckIfCharIsNotOnAir
	
StartJumpContinue:

	la t0, Jumping
	lw t1, 0(t0)
	
	# Impedir que o jogador pule durante um pulo
	bne t1, zero, StartJumpRet 

	li t1, 1
	sw t1, 0(t0)
	
	la t0, JumpCurrentHeight
	sw zero, 0(t0)
	
StartJumpRet:

	ret


# codigo bem parecido com o do movechar
# se alterar aqui tem que alterar la

CheckIfCharIsNotOnAir:
	
	la t0, CharPos						# le o endereço das coordenadas
	lh t1, 0(t0)						# le o x atual
	lh t2, 2(t0)						# le o y atual
	
	addi t2, t2, 1						# olha pro tile logo abaixo
	
	la t3, Camera						# le o endereço da camera
	lw t3, 0(t3)						# le a camera
	add t1, t1, t3						# adiciona o offset da camera na coord x

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
	lb s4, 0(s0)						# lê a cor neste ponto do mapa
	beq s4, zero, StartJumpContinue		# é parede, retorna

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
	lb s4, 0(s0)						# lê a cor neste ponto do mapa
	beq s4, zero, StartJumpContinue		# é parede, nao vai
	
	# ele tá no ar
	
	j StartJumpRet
