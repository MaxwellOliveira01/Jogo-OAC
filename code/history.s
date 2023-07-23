History:
	
	SaveRegisters()
	
	# Cena 1
	
	li t0, 0xFF200604
	lh s1, 0(t0)
	xori s1, s1, 1				# Pega o frame oculto
	
	la a0, dialogonovo1			# Desenha a cena de dialogo1
	li a1, 0					# no frame oculto
	li a2, 0
	mv a3, s1
	call Print
	
	li t0, 0xFF200604
	sw s1, 0(t0)				# inverte o frame do usuario
	xori s1, s1, 1				# Pega o frame oculto
	
	la a0, dialogonovo1			# Desenha a cena de dialogo1
	li a1, 0					# no frame oculto
	li a2, 0
	mv a3, s1
	call Print
	
	la t0, HistorySleepTimeInMs
	lw t0, 0(t0)
	
	li a7, 32					# ecall de sleep
	mv a0, t0
	ecall
	
	li t1,0xFF200000			# carrega o endereco de controle do KDMMIO
	lw t0,0(t1)					# Le bit de Controle Teclado
	andi t0,t0,0x0001			# mascara o bit menos significativo
   	bne t0,zero,HistoryReturn   # Se tem tecla pressionada entao vai para FIM
	
# Cena 2
	li t0, 0xFF200604
	lh s1, 0(t0)
	xori s1, s1, 1				# Pega o frame oculto
	
	la a0, dialogonovo2			# Desenha a cena de dialogo1
	li a1, 0					# no frame oculto
	li a2, 0
	mv a3, s1
	call Print
	
	li t0, 0xFF200604
	sw s1, 0(t0)				# inverte o frame do usuario
	xori s1, s1, 1				# Pega o frame oculto
	
	la a0, dialogonovo2			# Desenha a cena de dialogo1
	li a1, 0					# no frame oculto
	li a2, 0
	mv a3, s1
	call Print
	
	la t0, HistorySleepTimeInMs
	lw t0, 0(t0)
	
	li a7, 32					# ecall de sleep
	mv a0, t0
	ecall
	
	li t1,0xFF200000			# carrega o endereco de controle do KDMMIO
	lw t0,0(t1)					# Le bit de Controle Teclado
	andi t0,t0,0x0001			# mascara o bit menos significativo
   	bne t0,zero,HistoryReturn   # Se tem tecla pressionada entao vai para FIM
	
# Cena 3
	
	li t0, 0xFF200604
	lh s1, 0(t0)
	xori s1, s1, 1				# Pega o frame oculto
	
	la a0, dialogonovo3			# Desenha a cena de dialogo1
	li a1, 0					# no frame oculto
	li a2, 0
	mv a3, s1
	call Print
	
	li t0, 0xFF200604
	sw s1, 0(t0)				# inverte o frame do usuario
	xori s1, s1, 1				# Pega o frame oculto
	
	la a0, dialogonovo3			# Desenha a cena de dialogo1
	li a1, 0					# no frame oculto
	li a2, 0
	mv a3, s1
	call Print
	
	la t0, HistorySleepTimeInMs
	lw t0, 0(t0)
	
	li a7, 32					# ecall de sleep
	mv a0, t0
	ecall

	li t1,0xFF200000			# carrega o endereco de controle do KDMMIO
	lw t0,0(t1)					# Le bit de Controle Teclado
	andi t0,t0,0x0001			# mascara o bit menos significativo
   	bne t0,zero,HistoryReturn   # Se tem tecla pressionada entao vai para FIM
  	
	
# Cena 4:

	li t0, 0xFF200604
	lh s1, 0(t0)
	xori s1, s1, 1				# Pega o frame oculto
	
	la a0, dialogonovo4			# Desenha a cena de dialogo1
	li a1, 0					# no frame oculto
	li a2, 0
	mv a3, s1
	call Print
	
	li t0, 0xFF200604
	sw s1, 0(t0)				# inverte o frame do usuario
	xori s1, s1, 1				# Pega o frame oculto
	
	la a0, dialogonovo4			# Desenha a cena de dialogo1
	li a1, 0					# no frame oculto
	li a2, 0
	mv a3, s1
	call Print
	
	la t0, HistorySleepTimeInMs
	lw t0, 0(t0)
	
	li a7, 32					# ecall de sleep
	mv a0, t0
	ecall

	li t1,0xFF200000			# carrega o endereco de controle do KDMMIO
	lw t0,0(t1)					# Le bit de Controle Teclado
	andi t0,t0,0x0001			# mascara o bit menos significativo
   	bne t0,zero,HistoryReturn   # Se tem tecla pressionada entao vai para FIM

	# Cena 5
	
	li t0, 0xFF200604
	lh s1, 0(t0)
	xori s1, s1, 1				# Pega o frame oculto
	
	la a0, dialogonovo5			# Desenha a cena de dialogo1
	li a1, 0					# no frame oculto
	li a2, 0
	mv a3, s1
	call Print
	
	li t0, 0xFF200604
	sw s1, 0(t0)				# inverte o frame do usuario
	xori s1, s1, 1				# Pega o frame oculto
	
	la a0, dialogonovo5			# Desenha a cena de dialogo1
	li a1, 0					# no frame oculto
	li a2, 0
	mv a3, s1
	call Print
	
	la t0, HistorySleepTimeInMs
	lw t0, 0(t0)
	
	li a7, 32					# ecall de sleep
	mv a0, t0
	ecall	

	li t1,0xFF200000			# carrega o endereco de controle do KDMMIO
	lw t0,0(t1)					# Le bit de Controle Teclado
	andi t0,t0,0x0001			# mascara o bit menos significativo
   	bne t0,zero,HistoryReturn   # Se tem tecla pressionada entao vai para FIM
  	
# Cena 6

	li t0, 0xFF200604
	lh s1, 0(t0)
	xori s1, s1, 1				# Pega o frame oculto
	
	la a0, dialogonovo6			# Desenha a cena de dialogo1
	li a1, 0					# no frame oculto
	li a2, 0
	mv a3, s1
	call Print
	
	li t0, 0xFF200604
	sw s1, 0(t0)				# inverte o frame do usuario
	xori s1, s1, 1				# Pega o frame oculto
	
	la a0, dialogonovo6			# Desenha a cena de dialogo1
	li a1, 0					# no frame oculto
	li a2, 0
	mv a3, s1
	call Print
	
	la t0, HistorySleepTimeInMs
	lw t0, 0(t0)
	
	li a7, 32					# ecall de sleep
	mv a0, t0
	ecall
	
	li t1,0xFF200000			# carrega o endereco de controle do KDMMIO
	lw t0,0(t1)					# Le bit de Controle Teclado
	andi t0,t0,0x0001			# mascara o bit menos significativo
   	bne t0,zero,HistoryReturn   # Se tem tecla pressionada entao vai para FIM
  	
# Cena 7

	li t0, 0xFF200604
	lh s1, 0(t0)
	xori s1, s1, 1				# Pega o frame oculto
	
	la a0, dialogonovo7			# Desenha a cena de dialogo1
	li a1, 0					# no frame oculto
	li a2, 0
	mv a3, s1
	call Print
	
	li t0, 0xFF200604
	sw s1, 0(t0)				# inverte o frame do usuario
	xori s1, s1, 1				# Pega o frame oculto
	
	la a0, dialogonovo7			# Desenha a cena de dialogo1
	li a1, 0					# no frame oculto
	li a2, 0
	mv a3, s1
	call Print
	
	la t0, HistorySleepTimeInMs
	lw t0, 0(t0)
	
	li a7, 32					# ecall de sleep
	mv a0, t0
	ecall
	
HistoryReturn:

	LoadRegisters()
	ret
