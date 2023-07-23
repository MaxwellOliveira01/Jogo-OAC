Utils:
	SaveRegisters()
	
	# Printa a posição atual do personagem
	
	la t0, CharPos
	lh t1, 0(t0)				# Lê o x atual do personagem
	lh t2, 2(t0)				# Lê o y atual do personagem
	#la t0, Camera
	#lw t3, 0(t0)				# Lê a camera atual
	la t0, CharDir				
	lw t3, 0(t0)				# Lê a direção atual
	
	la t0, Jumping
	lw t3, 0(t0)
	
	DebugInt("x atual", t1)
	DebugInt("y atual", t2)
	DebugInt("jumping", t3)
	DebugString("") 			# pular linha
	
	LoadRegisters()
	
	ret
