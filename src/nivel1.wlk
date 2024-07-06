import niveles.*
import wollok.game.*
import nivel2.*
import personajes.*

const nivel1 = new Nivel(
	
	fondo = new Fondo(image="carretera.png"),
	
	enemigos = [
        new Enemigo(position = game.at(6,16)), // cambie un poco las posiciones en este nivel
        new Enemigo(position = game.at(5,15)),
        new Enemigo(position = game.at(7,12)),
        new Enemigo(position = game.at(6,14)),
        new Enemigo(position = game.at(8,12))
    ],
    combustible = [
        new Combustible(position = game.at(6,10))
	]
	,
	siguienteNivel = nivel2,
	posInicialJugador = game.at(5,1)
)


