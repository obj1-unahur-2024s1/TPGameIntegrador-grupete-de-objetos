import wollok.game.*
import juego.*

object inicioDeJuego {
	method configuracion() {
		
		game.title("Road Fighter")
		game.cellSize(50)
		game.height(10)
		game.width(15)
		game.boardGround("carreteraEstatica.png")
		iniciarJuego.visualizarObjetos()
		game.start()
		
	}
	
}
