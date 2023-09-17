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

	call LifeDisplay
	call Midi
	call Jump
	call Tec
	call CheckDamage
	call CheckWin
	
	j Game

# === Região para dar includes === #

.data

#.include "sprites/charDireita.data"
#.include "sprites/charEsquerda.data"
#.include "sprites/map.s"

.include "sprites/mario1-dir.data"
.include "sprites/mario1-esq.data"

.include "sprites/mario2-dir.data"
.include "sprites/mario2-esq.data"

.include "sprites/mario3-dir.data"
.include "sprites/mario3-esq.data"

.include "sprites/mario4-dir.data"
.include "sprites/mario4-esq.data"

.include "sprites/dialogojogo1.data"
.include "sprites/dialogojogo2.data"
.include "sprites/dialogojogo3.data"

.include "sprites/dialogonovo1.data"
.include "sprites/dialogonovo2.data"
.include "sprites/dialogonovo3.data"
.include "sprites/dialogonovo4.data"
.include "sprites/dialogonovo5.data"
.include "sprites/dialogonovo6.data"
.include "sprites/dialogonovo7.data"
.include "sprites/map.data"
.include "sprites/mapHitBox.data"
.include "sprites/gameover.data"
.include "sprites/wingame.data"

#.include "sprites/mapHitBox2.data" # apagar isso, é só um teste

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
.include "code/selectSpriteCharacter.s"
.include "code/midi.s"
.include "code/jump.s"
.include "code/lifeManager.s"
.include "code/gameOver.s"
.include "code/theEnd.s"
.include "code/CheckWin.s"

.include "code/SYSTEMv21.s"
