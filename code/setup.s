Setup:
	SaveRegisters()
	
	# Desenha o mapa inicial 'map'
		
	la a0, map
	li a1, 0
	li a2, 0
	li a3, 0
	call Print
	li a3, 1
	call Print
	
	# Desenha o personagem 
	
	la a0, CharDireita
	la t0, CharPos
	lh a1, 0(t0)
	lh a2, 2(t0)
	li a3, 0
	call Print
	li a3, 1
	call Print
	
	LoadRegisters()
	
	ret
