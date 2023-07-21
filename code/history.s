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
	
	li a7, 32					# ecall de sleep
	mv a0, t0
	ecall
	
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
	
	li a7, 32					# ecall de sleep
	mv a0, t0
	ecall
	
	
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
	
	la t0, HistorySleepTimeInMs
	lw t0, 0(t0)
	
	li a7, 32					# ecall de sleep
	mv a0, t0
	ecall



	LoadRegisters()
	ret
