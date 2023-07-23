Tec:
		
	li t1,0xFF200000			# carrega o endereco de controle do KDMMIO
	lw t0,0(t1)					# Le bit de Controle Teclado
	andi t0,t0,0x0001			# mascara o bit menos significativo
   	beq t0,zero,FIM   		   	# Se nao ha tecla pressionada entao vai para FIM
  	lw t2,4(t1)  				# le o valor da tecla tecla

	li t0,'d'
	li a0,8						# add em x para ir pra direita [MUITO CUIDADO AO ALTERAR ISSO!!!!!
								# VAI TER QUE CORRIGIR O t4 do 1° for do PrintMap e o 2° for todo]
	li a1,0						# add em y pra ir pra direita
	li a2,1						# nova direção: Direita 
	beq t2,t0, MoveSomething	# se tecla pressionada for 'd', move para direita
	
	li t0,'a'
	li a0,-8					# add em x para ir pra esq			
	li a1,0						# add em y para ir pra esq
	li a2,0						# nova direção: Esquerda
	beq t2,t0, MoveSomething	# se tecla pressionada for 'a', move pra esquerda
	
#	li t0, 's'
#	li a0, 0
#	li a1, 8
#	la a2, CharDir
#	lw a2, 0(a2)				# mantém a mesma direção
#	beq t2, t0, MoveSomething
	
#	li t0, 'w'
#	li a0, 0
#	li a1, -8
#	la a2, CharDir
#	lw a2, 0(a2)				# mantém a mesma direção
#	beq t2, t0, MoveSomething

	li t0, 'w'
	beq t2, t0, StartJump

	li t0, 'm'
	beq t2, t0, InvMuteMidi
	
	li t0, 'k'
	beq t2, t0, Utils
		
FIM:	ret						# retorna
