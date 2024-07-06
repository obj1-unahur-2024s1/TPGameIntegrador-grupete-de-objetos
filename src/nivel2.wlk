import niveles.*
import wollok.game.*
import personajes.*

const nivel2 = new Nivel(
		
	fondo = new Fondo(image="carreteranivel2.png"), /*agrego la imagen de la carretera*/
	
	  enemigos = [
        new Enemigo(position = game.at(5,13)), // arregle un poco las posiciones para que no esten dispersas
        new Enemigo(position = game.at(7,12)),
       new Enemigo(position = game.at(6,16)),
        new Enemigo(position = game.at(8,15)),
        new Enemigo(position = game.at(4,13)),
        new Enemigo(position = game.at(7,14))
    ],
    combustible = [
        new Combustible(position = game.at(4,17))
	]
	,
	siguienteNivel = null,
	posInicialJugador = game.at(5,1)
)