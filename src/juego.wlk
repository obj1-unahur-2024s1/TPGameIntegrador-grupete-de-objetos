import configuracion.*
import wollok.game.*
import visuales.*
import niveles.*
import personajes.*

object juego {
	
	const iniciado = estadoDelJuego
	
	method iniciar() {
		configuracion.pantallaConfig()
		imagenInicio.mostrar()
		self.reproducirSonidoInicial()
		self.configurarTeclasIniciales()
		configuracion.configurarTeclas() // Modificacion para que ande la tecla R de reinicio
		
		game.start()
	}
	
	method reiniciarDesdeCero() { 
        // Reinicia el estado del juego
        game.clear()
        estadoDelJuego.cambiarValor(false)
        jugador.reiniciarVidas()
        jugador.reiniciarPuntos()
        configuracion.cargaYInicioDelJuego(visualNivel1, iniciado, gestorDeNiveles.nivelActual())
        self.iniciar() // Vuelve a llamar a iniciar para empezar desde cero
    }
    
	method reproducirSonidoInicial(){
		var  sound = game.sound("sonidos/game_start.wav")
		game.schedule(500, { sound.play()} )
		keyboard.enter().onPressDo({sound.stop()})
	}
	
	
	//metodo que me dice que gane/
	method ganar(){
		game.clear()
		win.mostrar()
		estadoDelJuego.cambiarValor(false)
		self.configurarTeclasReinicio()
	}
	
	//metodo que me dice que game over , agrega la pantalla/
	method perder(){
		imagenGameOver.mostrar()
        estadoDelJuego.cambiarValor(false)
        self.configurarTeclasReinicio()
	}
	
	method configurarTeclasIniciales(){
		 keyboard.enter().onPressDo({
            configuracion.cargaYInicioDelJuego(visualNivel1, iniciado, gestorDeNiveles.nivelActual())
        })
        
        keyboard.r().onPressDo({
            self.reiniciarDesdeCero()
        })
	}
	
	method configurarTeclasReinicio() {
        keyboard.enter().onPressDo({
            self.reiniciarDesdeCero()
        })
    }
	
}
 /*Objeto que se encarga de manejar el estado de mi juego*/
object estadoDelJuego{
	var estaIniciado = false
	
	method estaIniciado() = estaIniciado
	
	method cambiarValor(nuevoValor){
		estaIniciado = nuevoValor
	}
}
