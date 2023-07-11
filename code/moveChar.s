MoveChar:
	
	SaveRegisters()
	
	# Atualiza o OldCharPos
	
	la t0,CharPos				#carrega o endereço da posição atual
	la t1,OldCharPos			#carrega o endereço da posiçõ antiga

    lw t2,0(t0)					#Carrega a posição atual
    sw t2,0(t1)					#Salva a posição atual em OLD_CHAR_POS
	
	la t0,CharPos				#carrega o endereço da posição atual
	la t1,OldCharPos			#carrega o endereço da posiçõ antiga

    lw t2,0(t0)					#Carrega a posição atual
    sw t2,0(t1)					#Salva a posição atual em OLD_CHAR_POS

    lh t1, 0(t0)                # Carrega o x em t1
    add t1, t1, a0              # add o incremento no x
    sh t1, 0(t0)                # Salva o novo x

    lh t1, 2(t0)                # Carrega o y em t1
    add t1, t1, a1              # add o incremento no y
    sh t1, 2(t0)                # Salva o novo y
	
	# Apaga o rastro
	la a0, tile
	la t0, OldCharPos
	lh a1, 0(t0)
	lh a2, 2(t0)
	li a3, 0
	call Print

	# Desenha o personagem na coord nova
	la a0, CharDireita
	la t0, CharPos
	lh a1, 0(t0)
	lh a2, 2(t0)
	li a3, 0
	call Print

	LoadRegisters()

MoveCharReturn: 
	ret
