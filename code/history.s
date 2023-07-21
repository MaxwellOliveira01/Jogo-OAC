History:
	
	SaveRegisters()
	
	li t0, 0xFF200604
	lh s1, 0(t0)
	xori s1, s1, 1				# Pega o frame oculto
	
	la a0, dialogojogo1			# Desenha a cena de dialogo1
	li a1, 0					# no frame oculto
	li a2, 0
	li a3, 0
	call Print
	mv a3, s1
	call Print
	
	li t0, 0xFF200604
	sw s1, 0(t0)				# inverte o frame do usuario
	xori s1, s1, 1				# Pega o frame oculto
	
	la a0, dialogojogo1			# Desenha a cena de dialogo1
	li a1, 0					# no frame oculto
	li a2, 0
	li a3, 0
	call Print
	mv a3, s1
	call Print
	
	la t0, HistorySleepTimeInMs
	lw t0, 0(t0)
	
	li a7, 30					# ecall de pegar o tempo agr
	ecall
	mv t2, a0					# pega os 30 bits menores
								# esse vai ser o tempo base 
								
WaitScene1:
	li a7, 30					# pega o tempo agr
	ecall
	mv t3, a0					# pega os 30 bits menores do tempo agr
	sub t3, t3, t2				# subtrai do tempo base pra ver quanto tempo passou
	bleu t3, t0, WaitScene1
	
	# CENA 2
	
	li t0, 0xFF200604
	lh s1, 0(t0)
	xori s1, s1, 1				# Pega o frame oculto
	
	la a0, dialogojogo2			# Desenha a cena de dialogo1
	li a1, 0					# no frame oculto
	li a2, 0
	li a3, 0
	call Print
	mv a3, s1
	call Print
	
	li t0, 0xFF200604
	sw s1, 0(t0)				# inverte o frame do usuario
	xori s1, s1, 1				# Pega o frame oculto
	
	la a0, dialogojogo2			# Desenha a cena de dialogo1
	li a1, 0					# no frame oculto
	li a2, 0
	li a3, 0
	call Print
	mv a3, s1
	call Print
	
	la t0, HistorySleepTimeInMs
	lw t0, 0(t0)
	
	li a7, 30					# ecall de pegar o tempo agr
	ecall
	mv t2, a0					# pega os 30 bits menores
								# esse vai ser o tempo base 
								
WaitScene2:
	li a7, 30					# pega o tempo agr
	ecall
	mv t3, a0					# pega os 30 bits menores do tempo agr
	sub t3, t3, t2				# subtrai do tempo base pra ver quanto tempo passou
	#DebugInt(t3)
	bleu t3, t0, WaitScene2
	
	
	# Cena 3
	
	li t0, 0xFF200604
	lh s1, 0(t0)
	xori s1, s1, 1				# Pega o frame oculto
	
	la a0, dialogojogo3			# Desenha a cena de dialogo1
	li a1, 0					# no frame oculto
	li a2, 0
	li a3, 0
	call Print
	mv a3, s1
	call Print
	
	li t0, 0xFF200604
	sw s1, 0(t0)				# inverte o frame do usuario
	xori s1, s1, 1				# Pega o frame oculto
	
	la a0, dialogojogo3			# Desenha a cena de dialogo1
	li a1, 0					# no frame oculto
	li a2, 0
	li a3, 0
	call Print
	mv a3, s1
	call Print
	
	la t0, HistorySleepTimeInMs
	lw t0, 0(t0)
	
	li a7, 30					# ecall de pegar o tempo agr
	ecall
	mv t2, a0					# pega os 30 bits menores
								# esse vai ser o tempo base 
								
WaitScene3:
	li a7, 30					# pega o tempo agr
	ecall
	mv t3, a0					# pega os 30 bits menores do tempo agr
	sub t3, t3, t2				# subtrai do tempo base pra ver quanto tempo passou
	bleu t3, t0, WaitScene3



	LoadRegisters()
	ret
