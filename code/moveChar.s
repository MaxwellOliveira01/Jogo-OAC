
# a0 = incremento em x
# a1 = incremento em y
# a2 = nova direção

MoveChar:
	
	SaveRegisters()
	
	j CheckBounds
	
ContinueMoveChar:

	# Salva a posição atual como antiga
	
	la t0,CharPos				# Carrega o endereço da posição atual
	la t1,OldCharPos			# Carrega o endereço da posiçõ antiga

    lw t2,0(t0)					# Carrega a posição atual
    sw t2,0(t1)					# Salva a posição atual em OLD_CHAR_POS

	la t0, CharDir				# Pega a direção atual
	lw t0, 0(t0)
	beq a2, t0, LoadSpriteDir	# a direção é igual, pula
	
	# a direção é diferente, zera os argumentos de movimento
	li a0, 0
	li a1, 0

LoadSpriteDir:

	# Carrega o sprite correto em s2
	# supoem que seja direita
	la s2, CharDireita
	
	# se for direita, então pode pular e começar a printar
	bne a2, zero, ContinueMovingChar
	
	# se não for, carrega a esquerda
	la s2, CharEsquerda

ContinueMovingChar:


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
	mv a0, s2
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
	mv a0, s2
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
	j ContinueMoveChar