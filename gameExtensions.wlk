import wollok.game.*
import mapa.*
import medidasDeFuerza.*
import personajes.*

object direccion {
	var property orientacion = "right"
	var property destino = gameext.provider().origin() 
	method arriba(){
		return self.orientacion() == "arriba"
	}
	method derecha(){
		return self.orientacion() == "derecha"
	}
	method izquierda(){
		return self.orientacion() == "izquierda"
	}
	method abajo(){
		return self.orientacion() == "abajo"
	} 
}

object decision{
	var property seteada = false
	var property valor = false  
}
object gameext {
	/* PROPIEDADES DE GAME EXTENDIDO
	- provider => game de wollok
	- decision => Decision corriente para aceptar pedido
	- bloquear => Estado global para bloquear movimiento
	- context => Variables accesibles para el contexto global (ej: referencias a todos los trabajadores, y jornada)
	 */
	const property provider = game
	const property decisionCorriente = decision
	var property bloquear = false
	const property context = new Dictionary()

	
	method irA(visual, direccion) {
		if (bloquear){
			return
		}
		if (self.puedeAvanzar(visual, direccion) and self.posicionEnRango(direccion.destino())){
			visual.position(direccion.destino())
			
		}
		else{
			visual.position()
		}
		return
	}
	method resetearDecision(){
		self.decisionCorriente().seteada(false)
		self.decisionCorriente().valor(false)
	}
	method interactuar(repartidor, objetos) {
		objetos.forEach({obj =>
		//Nos fijamos si el objeto es interactuable 
		if(obj.esInteractuable()){
			//Reseteamos la decision para no aceptar ni rechazar por accidente
			self.resetearDecision()
			//Hacemos que los trabajadores nos hagan pedidos
			self.provider().say(obj, obj.saludar(repartidor) + obj.pedidoActual().mensaje(repartidor))
			//Bloqueamos movimiento para no detonar la inteaccion por accidente
			self.bloquear(true)
			//Ventana de 3s para aceptar o rechazar pedido
			self.provider().schedule(3000, {
				if(self.decisionCorriente().seteada()){
					//Si seteaste la inteccion con x o z, procesa el pedido
					obj.pedirAyuda(repartidor,self.decisionCorriente().valor() == "z")
					//Se resetea decision
					self.resetearDecision()
				}
				//Muestra estadisticas luego de interaccion
				self.mostrarStats(repartidor)
				//Permite movimiento
				self.bloquear(false)
				//Verifica condicion de fin de juego
				self.verificarGameOver(repartidor)
				})
		}
		})
	}
	method puedeAvanzar(visual,direccion) {
		const objetos = []
		if(direccion.arriba()){
			objetos.addAll(self.provider().getObjectsIn(visual.position().up(1)))
		}
		else if(direccion.izquierda()){
			objetos.addAll(self.provider().getObjectsIn(visual.position().left(1)))
		}
		else if(direccion.abajo()){
			objetos.addAll(self.provider().getObjectsIn(visual.position().down(1)))
		}
		else if(direccion.derecha()){
			objetos.addAll(self.provider().getObjectsIn(visual.position().right(1)))
		}
		else{
			throw new Exception(message="Invalid key")
		}
		self.interactuar(visual, objetos)
	  return objetos.isEmpty()
	}
	
	method posicionEnRango(pos){
		//width() y height() -1 hacen que el asset se vea mejor pero pierde una casilla de interacción
		//TODO: Arreglar que no se corte el personaje
		return pos.x() < self.provider().width() and pos.y() < self.provider().height() and pos.x()>=0 and pos.y()>=0
	}

	method verificarEnergia(repartidor)
	{
		if (repartidor.energia() <= 0)
		{
			self.context().basicGet("jornada").terminar(repartidor, self.context().basicGet("trabajadores"))
			self.provider().say(repartidor, "Se reinicia la jornada")
			self.verificarGameOver(repartidor)
		}
	}
	method manejarMusicaHuelga() {
		if(!self.context().basicGet("musicaFondo").paused()){
			self.context().basicGet("musicaFondo").pause()
		}
		self.context().basicGet("musicaHuelga").resume()
		self.provider().schedule(7000, {
			self.context().basicGet("musicaHuelga").pause()
			
			self.bloquear(false)
			})
	}
	method mostrarStats(repartidor){
		game.say(repartidor, "C:" + repartidor.carisma() + " E:" + repartidor.energia() + " F:" + repartidor.fondos())
	}
	method agregarRepartidor(repartidor){
		self.provider().addVisual(repartidor)
		keyboard.w().onPressDo({ => 
			repartidor.image("repartidor_up.png")
			direccion.orientacion("arriba")
			direccion.destino(repartidor.position().up(1))
			self.irA(repartidor, direccion)
			const sfx = (self.provider().sound("footsteps.mp3"))
			sfx.play()
			
		})
		keyboard.s().onPressDo({ => 
			repartidor.image("repartidor_down.png")
			direccion.orientacion("abajo")
			direccion.destino(repartidor.position().down(1))
			self.irA(repartidor, direccion)
			const sfx = (self.provider().sound("footsteps.mp3"))
			sfx.play()
		})
		keyboard.d().onPressDo({ =>
			repartidor.image("repartidor_right.png") 
			direccion.orientacion("derecha")
			direccion.destino(repartidor.position().right(1))
			self.irA(repartidor, direccion)
			const sfx = (self.provider().sound("footsteps.mp3"))
			sfx.play()
		})
		keyboard.a().onPressDo({ => 
			repartidor.image("repartidor_left.png") 
			direccion.orientacion("izquierda")
			direccion.destino(repartidor.position().left(1))
			self.irA(repartidor, direccion)
			const sfx = (self.provider().sound("footsteps.mp3"))
			sfx.play()
		})
		keyboard.z().onPressDo({ => 
			self.decisionCorriente().seteada(true)
			self.decisionCorriente().valor("z")
			const sfx = self.provider().sound("accept.mp3")
			sfx.play()
		})
		keyboard.x().onPressDo({ => 
			self.decisionCorriente().seteada(true)
			self.decisionCorriente().valor("x")
			const sfx = self.provider().sound("reject.mp3")
			sfx.play()
		})

		keyboard.p().onPressDo({ =>
			if(self.bloquear()){
				return
			}
			self.provider().say(repartidor, "A LA HUELGA!")
			self.bloquear(true)
			self.manejarMusicaHuelga()
			self.provider().schedule(7001, {
				const huelga = new Huelga(repartidor = repartidor)
				self.context().basicGet("trabajadores").forEach({ trabajador => 
				repartidor.convocarA(huelga, trabajador)
				var mensaje = ""
				if(trabajador.adhiereA(huelga, repartidor)) {
					mensaje += "Si"
				} else {
					mensaje += "No"
				}
				self.provider().say(trabajador, mensaje + " adhiero") 
				})
				huelga.efecto()

				self.context().basicGet("musicaFondo").resume()
				self.context().basicGet("jornada").terminar(repartidor, self.context().basicGet("trabajadores"))
				self.provider().say(repartidor, "Se reinicia la jornada")
				self.verificarGameOver(repartidor)

			})
			
			
		})

		keyboard.b().onPressDo({
			self.provider().say(repartidor, "Canasta Basica: " + CANASTA_BASICA + " Sueldo: " + repartidor.sueldo())
			
		})
		keyboard.h().onPressDo({
				self.context().basicGet("trabajadores").forEach({
					trabajador => self.provider().say(trabajador, trabajador.darPista())
				})
			})

		keyboard.c().onPressDo({
			self.mostrarStats(repartidor)
			const sfx = self.provider().sound("stats.mp3")
			sfx.play()
		}) 
	}

	method ganar(repartidor)
	{
		if (repartidor.sueldo() >= CANASTA_BASICA)
		{
			self.provider().say(repartidor, "GANAMOS. El sueldo " + repartidor.sueldo() + " cubre la canasta básica")
			return true

		}
		return false
	}

	method perder(repartidor)
	{
		if ( repartidor.fondos() <= 0)
		{
			self.provider().say(repartidor, "PERDIMOS. Nos quedamos sin fondos...")
			
			return true
		}
		return false
	}

	method pausarTodaLaMusica() {
	 self.context().basicGet("musicaFondo").pause()
	}
	method verificarGameOver(repartidor) {
		if(self.perder(repartidor)){
			self.pausarTodaLaMusica()
			self.context().basicGet("musicaDerrota").play()
			self.provider().schedule(500, {
				self.gameOver()
			})
			return
	  }
		if(self.ganar(repartidor)){
			self.pausarTodaLaMusica()
			self.context().basicGet("musicaVictoria").play()
			self.provider().schedule(500, {
				self.gameOver()
			})
			return
	  }
	  return
	}
	method gameOver() {
	  self.provider().stop()
	}
}
