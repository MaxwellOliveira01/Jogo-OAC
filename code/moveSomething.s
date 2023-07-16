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
