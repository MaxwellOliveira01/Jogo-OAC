TheEnd:
	SaveRegisters()
	
	
	la a0, wingame
	li a1, 0
	li a2, 0
	li a3, 0
	call Print
	li a3, 1
	call Print
	
LoopTheEnd: j LoopTheEnd
	
	li a7, 10
	ecall
	
	LoadRegisters()
	ret	

	
