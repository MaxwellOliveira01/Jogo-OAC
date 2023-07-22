# Seleciona o sprite certo a ser usado agora
# Necessita olhar para a direção atual do personagem
# e para a quantidade de movimentos já feitos
# retorna a0 com o endereço a ser usado!!

SelectSpriteCharacter:
	SaveRegisters()
	
	la t0, CharDir
	lw t0, 0(t0)
	
	# se for zero, é pra ir pra esquerda
	beq t0, zero, SelectLeftSpriteCharacter
	
	# se não, vai pra direita
	j SelectRightSpriteCharacter
	
	
SelectSpriteCharacterReturn:
	
	LoadRegisters()
	
	ret	





SelectLeftSpriteCharacter:

	la t0, cntMovesX
	lw t0, 0(t0)

	la a0, CharEsquerda
	li t1, 0
	beq t0, t1, SelectLeftSpriteCharacterReturn

	la a0, CharEsquerda2
	li t1, 1
	beq t0, t1, SelectLeftSpriteCharacterReturn
	
	la a0, CharEsquerda3
	li t1, 2
	beq t0, t1, SelectLeftSpriteCharacterReturn
	
	la a0, CharEsquerda4
	li t1, 3
	beq t0, t1, SelectLeftSpriteCharacterReturn
			
SelectLeftSpriteCharacterReturn:
	j SelectSpriteCharacterReturn




SelectRightSpriteCharacter:

	la t0, cntMovesX
	lw t0, 0(t0)

	la a0, CharDireita
	li t1, 0
	beq t0, t1, SelectRightSpriteCharacterReturn

	la a0, CharDireita2
	li t1, 1
	beq t0, t1, SelectRightSpriteCharacterReturn
	
	la a0, CharDireita3
	li t1, 2
	beq t0, t1, SelectRightSpriteCharacterReturn
	
	la a0, CharDireita4
	li t1, 3
	beq t0, t1, SelectRightSpriteCharacterReturn

SelectRightSpriteCharacterReturn:	
	j SelectSpriteCharacterReturn

