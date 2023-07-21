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
	li a1, 16
	li a2, 16
	li a3, 0
	call Print
	li a3, 1
	call Print
	
	LoadRegisters()
	
	ret
