import wollok.game.*
import personajes.*
import niveles.*
import direcciones.*
import visuales.*
import juego.*


/*objeto de configuracion del juego*/

object configuracion {
	
	/*metodo de configuracion basica de la pantalla */
	method pantallaConfig (){
		game.title("Road fighter")
		game.width(12)
		game.height(10)
		game.cellSize(64)
		game.boardGround("carretera.jpg") /*imagen de inicio del juego*/
	}
	
	/*configuracion de inicio de juego mediante el enter */
	method cargaYInicioDelJuego(imagenNivel,estadoDelJuego , nivel){
		if(not estadoDelJuego.estaIniciado()){ //veo el estado de mi juego antes de iniciarlo
				self.cambiarImagen(imagenNivel)
				if(nivel != null){
				 game.schedule(2000,{ //Le añado un pequeño corto para que de margen y de esa manera insertar la img del nivel
				 nivel.iniciar()
				})
				}
				estadoDelJuego.cambiarValor(true)
			}	
	}
	
	/*configuro un metod*/
	method cambiarImagen(imagenActual){
		imagenActual.mostrar()	
	}
	
	/*agrego al objeto juego en el escenario*/
	method agregarPersonajes(personaje,posicion) {
		personaje.crear()
		personaje.position(posicion)
		self.configurarTeclas()
	}
	
	/*configuracion de teclas para realizar los movimientos*/
	method configurarTeclas() {
		keyboard.a().onPressDo({jugador.moverA(izquierda)})
		keyboard.d().onPressDo({jugador.moverA(derecha)})
		keyboard.enter().onPressDo({configuracion.cargaYInicioDelJuego(visualNivel1, estadoDelJuego, gestorDeNiveles.nivelActual())})
        keyboard.r().onPressDo({juego.reiniciarDesdeCero()}) // Añadi configuración para la tecla "R", reinicia el juego en cualquier momento de las partidas,
        													// no es lo mmismo que el enter en el game over/win
	}
	

}
