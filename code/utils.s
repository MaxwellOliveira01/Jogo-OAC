Utils:
	SaveRegisters()
	
	# Printa a posição atual do personagem
	
	la t0, CharPos
	lh t1, 0(t0)				# Lê o x atual do personagem
	lh t2, 2(t0)				# Lê o y atual do personagem
	la t0, Camera
	lw t3, 0(t0)				# Lê a camera atual
	
	DebugInt(t1)
	DebugInt(t2)
	DebugInt(t3)
	
	
	
	LoadRegisters()
	
	ret
