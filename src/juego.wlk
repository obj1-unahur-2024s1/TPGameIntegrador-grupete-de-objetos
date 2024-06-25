import wollok.game.*
import inicio.*

object iniciarJuego {
	var property autosAmarillo = []
	var property autosArcoiris = []
	
	method visualizarObjetos() {
		game.addVisual(jugador)
		game.addVisual(autoAmarillo)
		game.addVisual(autoArcoiris)
		game.addVisual(vidas)
		game.addVisual(kilometros)
	
		game.onTick(50, "iniciar", {
			autoAmarillo.mover()
			autoArcoiris.iniciar()
		})
		
		game.whenCollideDo(jugador, {e => e.chocaAlAutoRojo()})
		kilometros.iniciar()
		
		keyboard.right().onPressDo { jugador.moverDerecha() }
        keyboard.left().onPressDo { jugador.moverIzquierda() }
	}
	
}

object kilometros {
	
	var kilometros = 0
	
	method text() = kilometros.toString() + " kms"
	method textColor() = paleta.rojo()
	method position() = game.at(13,6)
	
	method aumentarKilometros(valor){
		kilometros += valor
	}
	
	method pasarKilometros() {
		kilometros = kilometros + 1
	}
	method iniciar(){
		kilometros = 0
		game.onTick(100,"kilometros",{self.pasarKilometros()})
	}
	method detener(){
		game.removeTickEvent("kilometros")
	}
}

object paleta {
	const property rojo = "FFFFFF"
}

object vidas {
	var property position = game.at(13,7)
	var property image = "bateriaLLena.png"
}

object jugador {
	var vida = 3
	var property position = game.at(7,1)
	var property kmRecorridos = 0
	
	method image() = "autitoRojo.png"
	
	method centrar() {
		position = game.center()
	}
	
	method vida() = vida
	
	method sumarUnaVida(){
		vida = vida + 1
	}
	
	method quitarVida() {
		if (self.position() == autoAmarillo.position()){
			if(vida >= 1){
				vida -= 1
				if (vida == 0) {
					game.schedule(50,{game.removeVisual(self)})
					game.boardGround("end.png")
				}
			}
		}
		self.mensaje()
	}
	
	method mensaje(){
		game.say(self, self.vida().toString())
	}
	
	method moverIzquierda() {
        if (position.x() > 0) {
            position = game.at(position.x() - 1, position.y())
        }
    }
	
	method moverDerecha() {
        if (position.x() < game.width() - 1) {
            position = game.at(position.x() + 1, position.y())
        }
    }
    
    
}

object autoAmarillo {
	
	const property largo = [0,2,4,3,5,1,6]
	var posicion = 0
	var position = self.posicionInicial()
	method image() = "autitoAmarillo.png"
	method position() = position
	
	method largo () = largo
		
	method posicionInicial() = game.at(game.height()-largo.get(posicion),10)
	
	method iniciar(){
		self.mover()
	}
	
	method posicion () = posicion
	
	method reiniciarPosicion(){
		posicion = posicion - 1
	}
	
	method sumarUnaPosicion(){
		posicion += 1
	}
	
	method mover(){
		if(position.y() == 0){
			position = self.posicionInicial()
		}
		if(self.posicion() == 6){
			self.reiniciarPosicion()
		}
		if(self.posicion() == 0){
			self.sumarUnaPosicion()
		}
		self.sumarUnaPosicion()
		position = position.down(1)
		if (position.y() == game.height())
			position = self.posicionInicial()
	}
	
	method chocaAlAutoRojo(){
		jugador.quitarVida()
	}

}


object autoArcoiris {
	
	const property largo = [6,5,4,3,2,1,0]
	var posicion = 0
	var position = self.posicionInicial()
	method image() = "autitoArcoiris.png"
	method position() = position
	
	method largo () = largo
		
	method posicionInicial() = game.at(game.height()-largo.get(posicion),10)
	
	method iniciar(){
		self.mover()
	}
	
	method posicion () = posicion
	
	method reiniciarPosicion(){
		posicion = 0
	}
	
	method sumarUnaPosicion(){
		posicion += 1
	}
	
	method mover(){
		if(position.y() == 0){
			position = self.posicionInicial()
		}
		if(self.posicion() == 6){
			self.reiniciarPosicion()
		}
		self.sumarUnaPosicion()
		position = position.down(1)
		if (position.y() == game.height())
			position = self.posicionInicial()
	}
 	
 	method chocaAlAutoRojo(){
		kilometros.aumentarKilometros(100)
		if(jugador.vida()!= 3){
			jugador.sumarUnaVida()
			jugador.mensaje()
		}
	}	
}
