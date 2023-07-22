
MoveCamera:
	SaveRegisters()

	j CameraCheckWalls
	
MoveCameraContinue:

	# Adiciona o incremento de movimento na camera
	la s0, Camera
	lw s1, 0(s0)
	add s1, s1, a0
	sw s1, 0(s0)

	# Adiciona um em cntMovesX
	la t0, cntMovesX			# Lê a quantidade de movimentos em x já feitos
	lw t1, 0(t0)
	addi t1, t1, 1				# add 1 e pega mod quantidade de sprites
	li t2, 4 					# quantidade de sprites de movimento
	rem t1, t1, t2				# pega mod
	sw t1, 0(t0)				# salva o valor novo
			
	# Desenha no frame oculto, inverte o frame e desenha no atual
	
	# Pega o frame oculto em s1
	
	li s1, 0xFF200604
	lh s1, 0(s1) 
	xori s1, s1, 1
	# Desenha a tile por cima do personagem no frame oculto
	
	#la a0, tile
	#la t0, CharPos
	#lh a1, 0(t0)
	#lh a2, 2(t0)
	#mv a3, s1
	#call Print

	# Desenha o mapa no frame oculto
	
	la a0, map
	li a1, 0
	li a2, 0
	mv a3, s1
	call PrintMap

	# Desenha a tile no lugar do personagem

	la a0, map
	la t0, CharPos
	lh a1, 0(t0)
	lh a2, 2(t0)
	addi a1, a1, -8				# Que gambiarrakkkkkkkkkkkkkkkkkk
	mv a3, s1
	la t0, CharDireita
	lw a4, 0(t0)
	lw a5, 4(t0)
	call PrintTile	

	# Desenha o personagem no no frame oculto

	#la a0, CharDireita
	call SelectSpriteCharacter
	la t0, CharPos
	lh a1, 0(t0)
	lh a2, 2(t0)
	mv a3, s1
	call Print
	
	# Inverte o frame atual
	li t0, 0xFF200604
	sw s1, 0(t0)
	
	# Pega o frame oculto dnv
	
	xori s1, s1, 1
	
	#la a0, tile
	#la t0, CharPos
	#lh a1, 0(t0)
	#lh a2, 2(t0)
	#mv a3, s1
	#call Print

	# Desenha o mapa no frame oculto

	la a0, map
	li a1, 0
	li a2, 0
	mv a3, s1
	call PrintMap

	# Desenha a tile por cima do personagem no frame oculto

	la a0, map
	la t0, CharPos
	lh a1, 0(t0)
	lh a2, 2(t0)
	mv a3, s1
	addi a1, a1, -8 			# Que gambiarrakkkkkkkkkkkkkkkkkk
	la t0, CharDireita
	lw a4, 0(t0)
	lw a5, 4(t0)
	call PrintTile

	# Desenha o personagem no no frame oculto

	#la a0, CharDireita
	call SelectSpriteCharacter
	la t0, CharPos
	lh a1, 0(t0)
	lh a2, 2(t0)
	mv a3, s1
	call Print
	
MoveCameraReturn:	

	LoadRegisters()
	
	ret









# Copiado do moveChar
# Se mexer aqui tem que mexer lá também

CameraCheckWalls:
	
	# Não alterar os argumentos!!!!!!!!!!
	# Ainda serão usados para os movimentos
	
	la t0, CharPos						# le o endereço das coordenadas
	lh t1, 0(t0)						# le o x atual
	lh t2, 2(t0)						# le o y atual
		
	add t1, t1, a0						# add o incremento em x
	add t2, t2, a1						# add o incremento em y
					
	# Ok, o personagem vai para (t1, t2). 
	# Olhar em mapHitBox se essas coordenadas não são uma parede
	# Lembrar de adicionar o offset da camera no x
	
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
	beq s4, zero, MoveCameraReturn		# é parede, nao vai
	
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
	beq s4, zero, MoveCameraReturn		# é parede, nao vai
	
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
	beq s4, zero, MoveCameraReturn		# é parede, nao vai
	
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
	lb s4, 0(s0)						# lê a cor neste ponto do mapa
	beq s4, zero, MoveCameraReturn		# é parede, nao vai
	
	# não é parede, pode ir
		
	j MoveCameraContinue