class Jornada
{
    method terminar(repartidor, trabajadores)
    {
        repartidor.energia(100)
        repartidor.fondos(repartidor.fondos() - repartidor.sueldo() / 20) // Se le resta la veinteava parte del sueldo a los fondos
        trabajadores.forEach({ trabajador => 
            trabajador.pedidosPosibles(trabajador.pedidos().size()) 
            trabajador.esInteractuable(true)
        }) // Esto resetea los pedidos posibles al tamaño original y lo vuelve a hacer interactuable
    }
}