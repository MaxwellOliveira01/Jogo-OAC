GameOver:
	SaveRegisters()
	
	# avisar que o cara perdeu, colocar uma tela preta
	# loop infinito
	# com a mensagem
	# HAHAHA, você não foi capaz de terminar o jogo?
	# Então terá que escutar a musica tema do mário pelo resto
	# dos seus dias!!!!!
	
	
	
	li a7, 10
	ecall
	
	LoadRegisters()
	ret
