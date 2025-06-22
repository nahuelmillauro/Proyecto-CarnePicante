import wollok.game.*
import pedidos.*
import mapa.*
import gameExtensions.gameext

const CANASTA_BASICA = 10000

class Personaje inherits Sprite (esInteractuable=true){
  const property nombre
  var property sueldo = 5000// El sueldo arranca siendo la mitad de la canasta básica
  var property image
  var property position

  method saludar(otro) = "Hola " + otro.nombre() + "."

  method hablarCon(otro) {
    return otro.responder()
  }
}

class Trabajador inherits Personaje {
    var property pedidos
    var property pedidosPosibles = self.pedidos().size()
    method adhiereA(medida, repartidor) {}

    var property pedidoActual = self.generarPedidoAleatoriamente()

    method renovarPedido(){
        if(self.pedidoActual().cerrado()){
            self.pedidoActual(self.generarPedidoAleatoriamente())
        }
    }
    method pedirAyuda(repartidor, decision) {
      self.pedidoActual().efecto(repartidor,decision)
      self.renovarPedido()
    }
  method generarPedidoAleatoriamente() {
    if(self.pedidosPosibles() == 0){
      self.esInteractuable(false)
      return self.pedidoActual()
    }
    const randomizer = 0.randomUpTo(self.pedidos().size()).floor()
    const pedidoElegido = self.pedidos().get(randomizer)
    self.pedidosPosibles(self.pedidosPosibles() - 1)

    return pedidoElegido
  }
  method darPista()
}

class Repartidor inherits Personaje {
    var property carisma = 100 // Valor entre 1 y 100
    var property energia = 100 // La jornada arranca con 100
    var property fondos = self.sueldo() // Los fondos arrancan siendo el sueldo
    var property pedidoActual = null

    const property pedidosTotales = []
    const property pedidosAceptados = []

    method convocarA(medida, trabajadorConvocado)
    {
        medida.convocarTrabajador(trabajadorConvocado)
    }

    method aceptar(pedido) {
        self.pedidosAceptados().add(pedido)
        self.pedidosTotales().add(pedido)
    }
  
    method rechazar(pedido) {
        self.pedidosTotales().add(pedido)
    }

    method mostrarPedido() = self.pedidoActual().nombre()

    method cerrarPedido(){
        self.pedidoActual().cerrar()
        self.pedidoActual(null)
    }
}


class Cocinero inherits Trabajador(pedidos = [new PrestarPlata(), new CubrirTurno(), new InspeccionAuditoria()]) {
    // Si al cocinero le aceptan más de la mitad de los pedidos, adhiere a la medida
    override method adhiereA(medida, repartidor) {
        try {
            return repartidor.pedidosAceptados().size() / repartidor.pedidosTotales().size() > 0.5
        }
        catch e: EvaluationError {
            return false
        }
        
    } 
    override method darPista(){
        return "Valoro ayudar a los compañeros"
    }
}


class Cajero inherits Trabajador(pedidos = [new PrestarPlata(), new CubrirTurno(), new InspeccionAuditoria()]) {
    // El cajero adhiere si el repartidor tiene más de 70/100 de carisma
    override method adhiereA(medida, repartidor) {
        return repartidor.carisma() > 70
    } 
    override method darPista(){
        return "Valoro a los líderes carismáticos"
    }
}


class Operario inherits Trabajador(pedidos = [new PrestarPlata(), new CubrirTurno(), new InspeccionAuditoria()]) {
    // El chico del depósito es empático y adhiere si lo ve muy cansado
    override method adhiereA(medida, repartidor) {
        return repartidor.energia() < 50
    }
    override method darPista(){
        return "Yo doy una mano al que está cansado"
    } 
}


class Administrativo inherits Trabajador(pedidos = [new PrestarPlata(), new CubrirTurno(), new InspeccionAuditoria()]) {
    // El administrativo solo adhiere si el repartidor no es un lumpen que ya se patinó el 75 % del sueldo
    override method adhiereA(medida, repartidor) {
        const condicionAdhesion = repartidor.fondos() > repartidor.sueldo() * 0.75
        return condicionAdhesion
    }

    override method darPista(){
        return "Respeto al que ahorra"
    } 

}