CheckWin:
	SaveRegisters()
	
	la t0, CharPos
	lh t1, 0(t0)
	lh t2, 2(t0)
	
	li t3, 208
	bne t1, t3, CheckWinReturn
	
	li t3, 192
	bne t2, t3, CheckWinReturn
	
	call TheEnd
	
	
CheckWinReturn:
	
	LoadRegisters()
ret
