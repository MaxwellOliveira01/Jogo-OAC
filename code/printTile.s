	
	
#################################################
#	a0 = endere�o imagem						#
#	a1 = x	(no bitmap)							#
#	a2 = y	(no bitmap)							#
#	a3 = frame (0 ou 1)							#
#	a4 = cnt de linhas							#
#	a5 = cnt de colunas							#
#################################################

# Desenha o tile do mapa
	
PrintTile:

	SaveRegisters()

	la s0, Camera
	lw s0, 0(s0)

	# for i ... linhas 
	# for j .... colunas
	
	mv t0, zero						# -> i
	mv t1, zero						# -> j
	
	li s1,0xFF0				# carrega 0xFF0 em s1
	add s1,s1,a3			# adiciona o frame ao FF0 (se o frame for 1 vira FF1, se for 0 fica FF0)
	slli s1,s1,20			# shift de 20 bits pra esquerda (0xFF0 vira 0xFF000000, 0xFF1 vira 0xFF100000)
	add s1, s1, a1			# move para a coluna certa
	li t3, 320				# quantidade de colunas da tela
	mul t3,t3, a2			# 320 * y
	add s1, s1, t3			# move o ponteiro do bitmap para a linha correta
	
	mv s2, a0				# pega o endereço da imagem
	lw s3, 0(s2)			# le a quantidade de colunas da imagem
	addi s2, s2, 8			# pula a largura/comprimento na imagem
	
	add s2, s2, a1			# coloca o ponteiro do mapa na coluna certa
	add s2, s2, s0			# coluna passada + offset da camera
	mul t3, a2, s3			# t3 = largura_imagem * y
	add s2, s2, t3			# coloca o ponteiro do mapa na linha certa
	
PrintTileFor:
	
	# bitmap[linha][coluna] = &map(a0)[linha][coluna + offset]	
		
	lw t4, 0(s2)					# le a word do mapa
	sw t4, 0(s1)					# salva no bitmap
	
	addi t1, t1, 4					# incrementa a coluna do for
	addi s1, s1, 4					# incrementa a coluna do bitmap
	addi s2, s2, 4
	blt t1, a4, PrintTileFor		# continua printando as colunas
	
	addi s1, s1, 320				# s1 += 320
	sub s1, s1, a5					# s1 -= largura da imagem
	# ^ isso serve pra "pular" de linha no bitmap display
		
	add s2, s2, s3					# s2 += quantidade de colunas do mapa
	sub s2, s2, a5					# s2 -= largura da imagem
			
	mv t1, zero						# zera a coluna atual
	addi t0, t0, 1					# incrementa a linha
	blt t0, a5, PrintTileFor 		# printa a proxima linha

	LoadRegisters()
	
	ret
	