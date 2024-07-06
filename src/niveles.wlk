import wollok.game.*
import nivel1.*
import nivel2.*
import juego.*
import configuracion.*
import visuales.*
import personajes.*
import direcciones.*

/*manejar los niveles del juego*/
object gestorDeNiveles {
	
	const autoRojo = jugador /*variable en objeto el cual puedo usar en cualquier lugar de mi juego*/	
	var property nivelActualNumero = 1
	var nivelActual = nivel1
	var property vidas = 3
	var cambioDeNivel = false
	
	method cambioDeNivel () = cambioDeNivel	
	
	method siCambioDeNivel (){
		cambioDeNivel = true
	}
	
	method nivelActual() = nivelActual
	
	method cambiarDeNivel(nuevoNivel) {
		nivelActual = nuevoNivel
	}	
	
	method autoRojo() = autoRojo
	
	method ultimoNivel() = self.nivelActual().siguienteNivel () == null
	
	method cambiarDeNivel() {
	  	/*condicion que delimita mi cambio */
	  	if (self.autoRojo().puntos() == 10 and not self.ultimoNivel()) {
            self.pasarDeNivel()
    	} else if (self.autoRojo().vidas() == 0) {	
    		self.perderJuego()
    		}
    	else if(self.ultimoNivel() and self.autoRojo().puntos() == 10){
    		self.ganarJuego()
    	}
    }
    method pasarDeNivel(){
    	game.clear() 
            estadoDelJuego.cambiarValor(false)
            self.autoRojo().reiniciarPuntos() // reinicio los puntos para evitar que se genere un bucle en el llamado
            self.autoRojo().reiniciarVidas() // reinicio las vidas para evitar que se genere un bucle en el llamado
            self.cambiarDeNivel(nivel2)
            configuracion.cargaYInicioDelJuego(visualNivel2, estadoDelJuego, nivel2)
    }
    
    method perderJuego(){
    	game.clear() 
    		estadoDelJuego.cambiarValor(false)
    		configuracion.cargaYInicioDelJuego(imagenGameOver, estadoDelJuego, null)
    		var sound = game.sound("sonidos/game_over.wav")
    		game.schedule(500, {sound.play()})
    		keyboard.enter().onPressDo {
    			juego.iniciar()
		}
	}
	method ganarJuego(){
		game.clear() 
    		estadoDelJuego.cambiarValor(false)
    		configuracion.cargaYInicioDelJuego(win, estadoDelJuego, null)
    		var sound = game.sound("sonidos/win.wav")
    		game.schedule(500, {sound.play()})
    		keyboard.enter().onPressDo {
    			juego.iniciar()}
    		 /*añadir imagen win*/
    		 
	}
	method verificarColision() { /*verifica si el auto rojo choco ya sea a un Enemigo y a un Combustible*/
		game.whenCollideDo(self.autoRojo(), {auto =>
			auto.choco()
		})
	}
	
	method actualizar() { /*Nuevo método para actualizar el estado del juego*/
        self.cambiarDeNivel()
    }
}

class Nivel {
	
	/*atributos de mi clase */
	var property enemigos = [] 
	var property combustible = []
	var property siguienteNivel = null
	var property posInicialJugador
	var property fondo /*fondo de carretera*/
	
	/*encargado de iniciar el juego - es llamado en el archivo juego.wlk */
	method iniciar() {
		 self.cargarEscenario()
		 gestorDeNiveles.verificarColision()
	     game.onTick(1000, self.identity().toString(), {gestorDeNiveles.actualizar()})
	}
	
	method cargarEscenario() {
		game.clear()
		self.crearCarretera(fondo)
		configuracion.agregarPersonajes(gestorDeNiveles.autoRojo(), posInicialJugador)
		self.crearTodos(enemigos)
		self.crearTodos(combustible)
		self.moverAutos(enemigos) /*cuando se carga el nivel los autos se moveran*/
		self.moverAutos(combustible) 
	}
	
	/*metodos encargados de la logica del escenario y los objetos involucrados*/
	
	method crearCarretera(fondoActual) {
		fondoActual.crear()
	}
	
	method crearTodos(listaDeObjetos) {
		listaDeObjetos.forEach({objeto => objeto.crear()})
	}
	
	method moverAutos(listaDeObjetos) {
		/*recorre la lista de enemigos y los hace moverse*/
		listaDeObjetos.forEach({objeto => objeto.moverAutomaticamente(abajo)})
	}
	
	method volverACrear() {
        if (self.enemigos().size() < 2) {
            const nuevoEnemigo = new Enemigo(position = game.at(0.randomUpTo(6).truncate(0) + 3, 11))
            self.enemigos().add(nuevoEnemigo)
            nuevoEnemigo.crear()
            nuevoEnemigo.moverAutomaticamente(abajo)
        }
    }
}
