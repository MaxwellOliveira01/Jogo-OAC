MoveSomething:

	# Recebe o incremento de x em a0
	# Recebe o incremento de y em a1
	
	# Se o movimento for para a direita (x > 0)
	# Se a camera < TamanhoMapa
	# E se o x atual do personagem for >= larguraTela / 2
	# 		Então quem deve se mover é a camera
	# Caso contrário quem se move é o personagem

	
	#if x <= 0
	bge zero, a0, MoveChar
	
	#if camera >= tamanhoMapa:
	la t0, Camera
	lw t0, 0(t0)

	# Pega a largura do mapa
	la t2, map
	lh t2, 0(t2)
	
	bge t0, t2, MoveChar
	
	#if 2 * x_atual >= larguraTela:
	la t0, CharPos	
	lh t0, 0(t0)
	slli t0, t0, 1
	
	la t1, LarguraTela
	lw t1, 0(t1)
	
	blt t0, t1, MoveChar
	
	j MoveCamera
	
	ret

MoveChar:
	
	SaveRegisters()
	
	# Salva a posição atual como antiga
	
	la t0,CharPos				#carrega o endereço da posição atual
	la t1,OldCharPos			#carrega o endereço da posiçõ antiga

    lw t2,0(t0)					#Carrega a posição atual
    sw t2,0(t1)					#Salva a posição atual em OLD_CHAR_POS

	# Adiciona os incrementos em x e y

    lh t1, 0(t0)                # Carrega o x em t1
    add t1, t1, a0              # add o incremento no x
    sh t1, 0(t0)                # Salva o novo x

    lh t1, 2(t0)                # Carrega o y em t1
    add t1, t1, a1              # add o incremento no y
    sh t1, 2(t0)                # Salva o novo y
	
	# Desenha no frame oculto, inverte o frame e desenha no atual
	# Pega o frame oculto em s1
	li s1, 0xFF200604
	lh s1, 0(s1)
	xori s1, s1, 1
	
	# Desenha a tile em oldCharPos no frame oculto
	la a0, tile										
	la t0, OldCharPos
	lh a1, 0(t0)
	lh a2, 2(t0)
	mv a3, s1
	call Print
	
	# Desenha o personagem no frame oculto
	la a0, CharDireita
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
	la a0, tile										
	la t0, OldCharPos
	lh a1, 0(t0)
	lh a2, 2(t0)
	mv a3, s1
	call Print
	
	# Desenha o personagem no frame oculto
	la a0, CharDireita
	la t0, CharPos
	lh a1, 0(t0)
	lh a2, 2(t0)
	mv a3, s1
	call Print
	
	LoadRegisters()

MoveCharReturn: 
	ret


MoveCamera:
	SaveRegisters()
	
	# Adiciona o incremento de movimento na camera
	la s0, Camera
	lh s1, 0(s0)
	add s1, s1, a0
	sw s1, 0(s0)
	
	#DebugString("Camera se movendo")
	#DebugInt(s1)
	
	# Desenha no frame oculto, inverte o frame e desenha no atual
	
	# Pega o frame oculto em s1
	
	li s1, 0xFF200604
	lh s1, 0(s1)
	xori s1, s1, 1
	
	# Desenha a tile por cima do personagem no frame oculto
	
	la a0, tile
	la t0, CharPos
	lh a1, 0(t0)
	lh a2, 2(t0)
	mv a3, s1
	call Print

	# Desenha o mapa no frame oculto

	la a0, map
	li a1, 0
	li a2, 0
	mv a3, s1
	call PrintMap
	
	# Desenha o personagem no no frame oculto

	la a0, CharDireita
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
	
	# Desenha a tile por cima do personagem no frame oculto
	
	la a0, tile
	la t0, CharPos
	lh a1, 0(t0)
	lh a2, 2(t0)
	mv a3, s1
	call Print

	# Desenha o mapa no frame oculto

	la a0, map
	li a1, 0
	li a2, 0
	mv a3, s1
	call PrintMap
	
	# Desenha o personagem no no frame oculto

	la a0, CharDireita
	la t0, CharPos
	lh a1, 0(t0)
	lh a2, 2(t0)
	mv a3, s1
	call Print
	
	LoadRegisters()
	
	ret
