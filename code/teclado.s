Tec:		
	li t1,0xFF200000			# carrega o endereco de controle do KDMMIO
	lw t0,0(t1)					# Le bit de Controle Teclado
	andi t0,t0,0x0001			# mascara o bit menos significativo
   	beq t0,zero,FIM   		   	# Se nao ha tecla pressionada entao vai para FIM
  	lw t1,4(t1)  				# le o valor da tecla tecla
	
	#exemplo de receber um botão e chamar a função certa
	#li t0,'w'
	#beq t1,t0, UpdateChar
		
FIM:	ret					# retorna