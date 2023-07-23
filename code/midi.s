
.data
# Numero de Notas a tocar
NUM: .word 67

NOTAS: .word 60,468,55,468,52,468,57,312,59,312,58,156,57,312,55,156,64,312,67,156,69,312,65,156,67,312,64,312,60,156,62,156,59,468,60,468,55,468,52,468,
57,312,59,312,58,156,57,312,55,156,64,312,67,156,69,312,65,156,67,312,64,312,60,312,62,156,59,468,67,156,66,156,65,156,63,312,64,468,56,156,57,156,
60,312,57,156,60,156,62,312,67,156,66,156,65,156,63,312,64,468,72,312,72,156,72,624,67,156,66,156,65,156,63,312,64,468,56,156,57,156,60,156,56,156,
57,156,60,312,63,468,62,468,60,1405
.text



Midi:
	SaveRegisters()
	
	la t0, MuteMidi				# Checa se o MIDI está mutado
	lw t0, 0(t0)
	bne t0, zero, MidiReturn
	
	li a7, 30					# ecall de time
	ecall						# chama ecall
	
	la t0, PlayThCurrentNoteUntil
	lw t0, 0(t0)				# pega até quando a nota anterior
								# deve continuar tocando
								
	bleu a0, t0, MidiReturn		# a nota anterior deve continuar tocando
	
	# Pega a nota salva na memória
	la t0, NextNote
	lw t0, 0(t0)
	
	slli t0, t0, 1				# multiplica o indice atual por 2
								# pq tem que contar a nota e a duração
								
	slli t0, t0, 2				# multiplica por 4 pra dar o offset
								# de bytes nas notas
								
	la t1, NOTAS				# pega as notas
	add t1, t1, t0				# add o offset calculado
	
	lw t2, 0(t1)				# le a proxima nota
	lw t3, 4(t1)				# le a proxima duracao
	
	li a7, 30					# ecall de time
	ecall						# chama o ecall
	
	la t4, PlayThCurrentNoteUntil
	add t5, a0, t3				# tempo atual + duração
	sw t5, 0(t4)				# salva o valor na memoria
	
	mv a0, t2					# nota a ser tocada
	mv a1, t3					# tempo
	li a2, 87					# instrumento
	li a3, 100					# volume
	li a7, 31					# ecall de tocar nota
	ecall						# chama pra tocar
	
	la t0, NextNote				# incrementa o indice da proxima nota
	lw t1, 0(t0)
	addi t1, t1, 1
	la t2, NOTAS
	lw t2, 0(t2)
	rem t1, t1, t2				# salva o indice % quantidade de notas
	sw t1, 0(t0)
	
MidiReturn:

	LoadRegisters()
	ret









InvMuteMidi:
	SaveRegisters()
	
	# Inverte a variavel MuteMidi
	# Serve para mutar/desmutar o som
	
	la t0, MuteMidi
	lw t1, 0(t0)
	xori t1, t1, 1
	sw t1, 0(t0)
	
	LoadRegisters()




