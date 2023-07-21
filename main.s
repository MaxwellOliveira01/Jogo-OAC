.include "code/MACROSv21.s"

.data

.include "code/macros.s"
.include "code/constants.s"
.include "code/data.s"

.text

Main:
	
	#call History
	call Setup
	
Game:
	call Tec
	
	j Game
						
	li a7, 10
	ecall		

# === Região para dar includes === #

.data

.include "sprites/charDireita.data"
#.include "sprites/charDireitaMovendo.data"
.include "sprites/charEsquerda.data"
.include "sprites/map.s"
.include "sprites/dialogojogo1.data"
.include "sprites/dialogojogo2.data"
.include "sprites/dialogojogo3.data"

.text
.include "code/history.s"
.include "code/teclado.s"
.include "code/print.s"
.include "code/printMap.s"
.include "code/setup.s"
.include "code/moveChar.s"
.include "code/moveCamera.s"
.include "code/moveSomething.s"
.include "code/utils.s"
.include "code/printTile.s"

.include "code/SYSTEMv21.s"
