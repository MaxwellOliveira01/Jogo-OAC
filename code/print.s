#################################################
#	a0 = endere�o imagem						#
#	a1 = x										#
#	a2 = y										#
#	a3 = frame (0 ou 1)							#
#################################################
#	t0 = endereco do bitmap display				#
#	t1 = endereco da imagem						#
#	t2 = contador de linha						#
# 	t3 = contador de coluna						#
#	t4 = largura								#
#	t5 = altura									#
#################################################

Print:
	li t0,0xFF0				# carrega 0xFF0 em t0
	add t0,t0,a3			# adiciona o frame ao FF0 (se o frame for 1 vira FF1, se for 0 fica FF0)
	slli t0,t0,20			# shift de 20 bits pra esquerda (0xFF0 vira 0xFF000000, 0xFF1 vira 0xFF100000)
	add t0,t0,a1			# adiciona x ao t0
	li t1,320				# t1 = 320
	mul t1,t1,a2			# t1 = 320 * y
	add t0,t0,t1			# adiciona t1 ao t0
	addi t1,a0,8			# t1 = a0 + 8
	mv t2,zero				# zera t2
	mv t3,zero				# zera t3
	lw t4,0(a0)				# carrega a largura em t4
	lw t5,4(a0)				# carrega a altura em t5
	
Print_Linha:	
	lw t6,0(t1)				# carrega em t6 uma word (4 pixeis) da imagem
	sw t6,0(t0)				# imprime no bitmap a word (4 pixeis) da imagem
	addi t0,t0,4			# incrementa endereco do bitmap
	addi t1,t1,4			# incrementa endereco da imagem
	addi t3,t3,4			# incrementa contador de coluna
	blt t3,t4,Print_Linha	# se contador da coluna < largura, continue imprimindo
	
	addi t0,t0,320			# t0 += 320
	sub t0,t0,t4			# t0 -= largura da imagem
	# ^ isso serve pra "pular" de linha no bitmap display
	mv t3,zero				# zera t3 (contador de coluna)
	addi t2,t2,1			# incrementa contador de linha
	bgt t5,t2,Print_Linha	# se altura > contador de linha, continue imprimindo
	ret

#################################################
#	a0 = endere�o imagem						#
#	a3 = frame (0 ou 1)							#
#################################################

PrintMap:
	
	SaveRegisters()
	
	#for i nas linhas
	#	for j nas colunas até (largura-1)
	#		bitmap[i][j] = bitmap[i][j+1]
	
	
	# t0 = endereço base no bitmap display
	li t0,0xFF0				# carrega 0xFF0 em t0
	add t0,t0,a3			# adiciona o frame ao FF0 (se o frame for 1 vira FF1, se for 0 fica FF0)
	slli t0,t0,20			# shift de 20 bits pra esquerda (0xFF0 vira 0xFF000000, 0xFF1 vira 0xFF100000)
	mv t2,zero				# zera t2
	mv t3,zero				# zera t3
	li t4,312				# 320 - tamanho do movimento atual (numero de colunas) [isso tem que ser multiplo de 4(pq to usando load/save word)]
							# assert(tamanho do movimento atual == tamanho da tile)
	li t5,240				# carrega a altura em t5 do display
	
PrintMapLinha:
	lw s0, 4(t0)				# le o que tá no endereço da frente do bitmap
	sw s0, 0(t0)				# sava nesse endereço aqui
	#DebugInt(t3)
	addi t0, t0, 4				# avança o endereço do bitmap
	addi t3, t3, 4				# incrementa a coluna
	blt t3, t4, PrintMapLinha 	# coluna < largura-1, printa a proxima
	
	addi t0, t0, 320			# add a largura da imagem
	sub t0, t0, t4				# remove o numero de colunas
	
	mv t3, zero 				# zera o contador de coluna
	addi t2, t2, 1 				# incrementa a linha
	blt t2, t5, PrintMapLinha 	# linha atual <  ultima linha do display, printa a proxima
	

	
	# Zera as as variaveis para fazer o for abaixo
	
	#for i nas linhas
	#	bitmap[i][largura] = mapa[i][ultima coluna a ser mostrada]
	
	
	
	# t0 = endereço base no bitmap display
	li t0,0xFF0				# carrega 0xFF0 em t0
	add t0,t0,a3			# adiciona o frame ao FF0 (se o frame for 1 vira FF1, se for 0 fica FF0)
	slli t0,t0,20			# shift de 20 bits pra esquerda (0xFF0 vira 0xFF000000, 0xFF1 vira 0xFF100000)
	mv t2,zero				# zera t2
	mv t3,zero				# zera t3
	li t4,312				# 320 - tamanho do movimento atual (numero de colunas) [isso tem que ser multiplo de 4(pq to usando load/save word)]
							# assert(tamanho do movimento atual == tamanho da tile)
	li t5,240				# carrega a altura em t5 do display

	li s0, 320 				# quantidade maxima de colunas

	addi t0, t0, 312		# o ponteiro do bitmap tá no começo, agora vou mover pra penultima coluna

PrintMapLastCol:

	# apenas para teste, pinta a ultima coluna de branco
	
	#for t4 = [312, 320) passo = 4
	
	li s1, 0					# cor branca?
	sw s1, 0(t0)				# salva no bitmap nessa coluna
	sw s1, 4(t0)				# salva no bitmap na proxima coluna
	
	addi t0, t0, 320 			# avança o ponteiro do bitmap para a proxima linha
								# tamanho do tile ----> 320 - 8 = 312
	addi t2, t2, 1				# avança a linha atual
	blt t2, t5, PrintMapLastCol	# linha atual < ultima linha do display, printa a proxima
	
	LoadRegisters()

	ret
