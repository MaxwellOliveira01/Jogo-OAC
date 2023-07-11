Tec:
	
	#SaveRegisters() ????
		
	li t1,0xFF200000			# carrega o endereco de controle do KDMMIO
	lw t0,0(t1)					# Le bit de Controle Teclado
	andi t0,t0,0x0001			# mascara o bit menos significativo
   	beq t0,zero,FIM   		   	# Se nao ha tecla pressionada entao vai para FIM
  	lw t2,4(t1)  				# le o valor da tecla tecla

	li t0,'d'
	li a0,16					#add em x para ir pra direita
	li a1,0						#add em y pra ir pra direita
	li a2,0						#Nova direção
	beq t2,t0,MoveChar			# se tecla pressionada for 'd', move para direita
	
	li t0,'a'
	li a0,-16					#add em x para ir pra esq			
	li a1,0						#add em y para ir pra esq
	li a2, 2					#Nova direção do personagem
	beq t2,t0,MoveChar			# se tecla pressionada for 'a', move pra esquerda
	
	#LoadRegisters()
	
FIM:	ret						# retorna
