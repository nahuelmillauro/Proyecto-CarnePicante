import personajes.*

class MedidaDeFuerza {
    const property nombre
    const property costo
    const property repartidor
    const trabajadoresConvocados = #{}

    method convocarTrabajador(trabajador)
    {
        trabajadoresConvocados.add(trabajador)
    }

    method adhesion() // Porcentaje entre adherentes y no adherentes (true y false)
    {
        return trabajadoresConvocados.filter({trabajador => trabajador.adhiereA(self, self.repartidor())}).size() / trabajadoresConvocados.size()
    }

    method resultado()
    {
        return self.adhesion() > 0.5 // Verdadero si es mayor al 50 %
    }

    method efecto() {}
}


class Huelga inherits MedidaDeFuerza(nombre="huelga", costo=20) { // Si el resultado es positivo, se incrementa el carisma; si no, disminuyen los fondos
    
    override method efecto()
    {   
        
        if(self.resultado())
        {
            repartidor.sueldo(repartidor.sueldo() * 1.25) // Aumenta el sueldo un 25 %
        }
        else
        {
            repartidor.fondos((repartidor.fondos() - repartidor.sueldo() / 5)) // Se le descuenta el día
        }
        
    }
}