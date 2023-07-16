
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
