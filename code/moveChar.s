
# a0 = incremento em x
# a1 = incremento em y
# a2 = nova direção

MoveChar:
	
	SaveRegisters()
	
	j CheckBounds
	
ContinueToCheckWalls:

	j CheckWalls
	
ContinueMoveChar:

	# Se for movimento no eixo x, então
	# Adicionar um em cntMovesX
	
	beq zero, a0, NotMovingOnXAxis
	
	la t0, cntMovesX			# Lê a quantidade de movimentos em x já feitos
	lw t1, 0(t0)
	addi t1, t1, 1				# add 1 e pega mod quantidade de sprites
	li t2, 4 					# quantidade de sprites de movimento
	rem t1, t1, t2				# pega mod
	sw t1, 0(t0)				# salva o valor novo

NotMovingOnXAxis:

	# Salva a posição atual como antiga
	
	la t0,CharPos				# Carrega o endereço da posição atual
	la t1,OldCharPos			# Carrega o endereço da posiçõ antiga

    lw t2,0(t0)					# Carrega a posição atual
    sw t2,0(t1)					# Salva a posição atual em OLD_CHAR_POS

	la t0, CharDir				# Pega a direção atual
	lw t0, 0(t0)
	beq a2, t0, LoadSpriteDir	# a direção é igual, pula
	
ImpedingMovement:
	
	# a direção é diferente, zera os argumentos de movimento
	li a0, 0
	li a1, 0

LoadSpriteDir:

	# Adiciona os incrementos em x e y
	
	la t0,CharPos				# Carrega o endereço da posição atual

    lh t1, 0(t0)                # Carrega o x em t1
    add t1, t1, a0              # add o incremento no x
    sh t1, 0(t0)                # Salva o novo x

    lh t1, 2(t0)                # Carrega o y em t1
    add t1, t1, a1              # add o incremento no y
    sh t1, 2(t0)                # Salva o novo y
	
	la t0, CharDir				# Carrega o endereço de Char dir
	sw a2, 0(t0)				# Salva a nova direção
	
	# Desenha no frame oculto, inverte o frame e desenha no atual
	# Pega o frame oculto em s1
	
	li s1, 0xFF200604
	lh s1, 0(s1)
	xori s1, s1, 1
	
	# Desenha a tile em oldCharPos no frame oculto
	#la a0, tile										
	#la t0, OldCharPos
	#lh a1, 0(t0)
	#lh a2, 2(t0)
	#mv a3, s1
	#call Print
	
	la a0, map
	la t0, OldCharPos
	lh a1, 0(t0)
	lh a2, 2(t0)
	mv a3, s1
	la t0, CharDireita
	lw a4, 0(t0)
	lw a5, 4(t0)
	call PrintTile

	# Desenha o personagem no frame oculto
	#la a0, CharDireita
	#mv a0, s2
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
	
	# Desenha a tile em oldCharPos no frame oculto
	#la a0, tile										
	#la t0, OldCharPos
	#lh a1, 0(t0)
	#lh a2, 2(t0)
	#mv a3, s1
	#call Print

	la a0, map
	la t0, OldCharPos
	lh a1, 0(t0)
	lh a2, 2(t0)
	mv a3, s1
	la t0, CharDireita
	lw a4, 0(t0)
	lw a5, 4(t0)
	call PrintTile
	
	# Desenha o personagem no frame oculto
	#la a0, CharDireita
	#mv a0, s2
	call SelectSpriteCharacter
	la t0, CharPos
	lh a1, 0(t0)
	lh a2, 2(t0)
	mv a3, s1
	call Print
	
MoveCharReturn: 	
	LoadRegisters()
	ret














CheckBounds:

	# Não deixar o personagem sair do grid
	
	la t0, CharPos
	lh t1, 0(t0)				# Lê o x atual do personagem
	lh t2, 2(t0)				# Lê o y atual do personagem
	
	add t1, t1, a0				# Adiciona o incremento em x
	add t2, t2, a1				# Adiciona o incremento em y
	
	la t0, CharDireita
	lw t3, 0(t0)				# Carrega a largura do personagem
	lw t4, 4(t0)				# Carrega a altura do personagem
	
	#if t1 < 0 || t2 < 0
	blt t1, zero, MoveCharReturn
	blt t2, zero, MoveCharReturn
	
	#if t1 + tamanhoPersonagem > 320
	li t0, 320
	add t1, t1, t3 
	bgt t1, t0, MoveCharReturn
	
	#if t2 + alturaPersonagem >= 240
	li t0, 240
	add t2, t2, t4
	bgt t2, t0, MoveCharReturn
	
	# Ok, ele estará dentro do grid
	j ContinueToCheckWalls






















CheckWalls:
	
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
	beq s4, zero, ImpedingMovement		# é parede, nao vai
	
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
	beq s4, zero, ImpedingMovement		# é parede, nao vai
	
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
	beq s4, zero, ImpedingMovement		# é parede, nao vai
	
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
	beq s4, zero, ImpedingMovement		# é parede, nao vai
	
	# não é parede, pode ir
		
	j ContinueMoveChar
