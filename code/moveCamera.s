
MoveCamera:
	SaveRegisters()

	# Adiciona o incremento de movimento na camera
	la s0, Camera
	lw s1, 0(s0)
	addi s1, s1, 8
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
	
	LoadRegisters()
	
	ret
