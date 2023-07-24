GameOver:
	SaveRegisters()
	
	la a0, gameover
	li a1, 0
	li a2, 0
	li a3, 0
	call Print
	li a3, 1
	call Print
	
LoopGameOver: j LoopGameOver
	
	LoadRegisters()
	ret
