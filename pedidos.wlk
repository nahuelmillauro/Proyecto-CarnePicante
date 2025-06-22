class Pedido{
    const property nombre
    var property cerrado = false 
    method mensaje(repartidor)
    method efecto(repartidor, decision) {
      if (decision)
      {
        repartidor.aceptar(self)
        repartidor.energia(repartidor.energia() - 20)
      } else {
        repartidor.rechazar(self)
        repartidor.energia(repartidor.energia() - 20)
      }
      return decision
    }
    method cerrar() {
      self.cerrado(true)
    }

}

class PrestarPlata inherits Pedido(nombre="Prestar plata"){
    
    override method mensaje(repartidor) {
      return "Me prestas plata?"
    }
    override method efecto(personaje, decision) {
      super(personaje, decision)
      if(decision){
        personaje.fondos(personaje.fondos() - 500)
        personaje.carisma(personaje.carisma() + 50)       
      }
      else{
        personaje.carisma(personaje.carisma() - 70)
      }
      self.cerrar()

      return decision

    }

}

class CubrirTurno inherits Pedido(nombre="Cubrir turno"){
    override method mensaje(repartidor) {
      return "Me cubris hoy?"
    }
    override method efecto(personaje, decision) {
      super(personaje, decision)
      if(decision){
        personaje.energia(personaje.energia() - 20)
        personaje.fondos(personaje.fondos() + 250)
      }
      else{
        personaje.carisma(personaje.carisma() - 15)
      }
      self.cerrar()

      return decision
    }
}

class InspeccionAuditoria inherits Pedido(nombre="Inspeccion de auditoria"){
    override method mensaje(repartidor) {
      return "Me distraes a los inspectores?"
    }
    override method efecto(personaje, decision) {
      super(personaje, decision)
      if(decision){
        personaje.energia(personaje.energia() - 10)
        personaje.fondos(personaje.fondos() + 50)
      }
      else{
        personaje.carisma(personaje.carisma() - 20)
      }
      self.cerrar()
      return decision
    }
}

//La decision siempre es true, ya que el personaje no puede rechazar la sancion
class Sancion inherits Pedido(nombre="Sancion"){
    override method mensaje(repartidor) {
      return "Seras sancionado"
    }
    override method efecto(personaje, decision) {
        personaje.sueldo(personaje.fondos(personaje.fondos() -100))
      self.cerrar()

      return decision
    }
}

//Siempre es true, cómo vas a rechazar un pago extra?
class PagoExtra inherits Pedido(nombre="Pago extra"){
    override method mensaje(repartidor) {
      return "Te pagamos extra"
    }
    override method efecto(personaje, decision) {
        personaje.sueldo(personaje.fondos() + 50)
      self.cerrar()

      return decision
    }
}
