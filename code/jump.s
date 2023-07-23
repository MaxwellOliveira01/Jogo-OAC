Jump:
	SaveRegisters()
	
	# Ideia: A todo momento, puxa o cara para baixo
	# Se ele apertar para pular, então não puxa para baixo
	# Puxa para cima até o limite do pulo e dps deixa ir descendo normalmente
	# Quando descer tudo, seta a variavel para 0
	
	
	
	
JumpReturn:
	
	LoadRegisters()
	
	ret
	
	
	
	
	
	
	
	
	
	
	
	
	
StartJump:

	la t0, Jumping
	li t1, 1
	sw t1, 0(t0)
	
	ret