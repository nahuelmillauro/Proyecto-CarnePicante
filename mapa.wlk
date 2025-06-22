import wollok.game.*
mixin Sprite{
    var property esInteractuable
}
class Pared inherits Sprite (esInteractuable=false){
    const property image = null
    const property position
}
class Objeto inherits Sprite (esInteractuable=false){
    const property image = null
    const property position 
}
class Elemento inherits Sprite(esInteractuable=false){
    var property image
    const property position  
}



const obstaculos = [
    new Pared(position= game.at(1, 1)), new Pared(position= game.at(1, 2)), new Pared(position= game.at(1, 3)), new Pared(position= game.at(1, 4)), new Pared(position= game.at(1, 5)), 
    new Pared(position= game.at(1, 6)), new Pared(position= game.at(1, 7)), new Pared(position= game.at(1, 8)),new Pared(position= game.at(1, 10)), new Pared(position= game.at(1, 11)), 
    new Pared(position= game.at(1, 12)), new Pared(position= game.at(1, 13)), new Pared(position= game.at(1, 14)), new Pared(position= game.at(1, 15)), new Pared(position= game.at(1, 16)),
    new Pared(position= game.at(1, 17)), new Pared(position= game.at(1, 18)), new Pared(position= game.at(2, 1)), new Pared(position= game.at(3, 1)), new Pared(position= game.at(4, 1)),
    new Pared(position= game.at(5, 1)), new Pared(position= game.at(6, 1)), new Pared(position= game.at(7, 1)), new Pared(position= game.at(8, 1)),
    new Pared(position= game.at(1, 10)), new Pared(position= game.at(2, 1)), new Pared(position= game.at(2, 10)), new Pared(position= game.at(3, 10)), new Pared(position= game.at(4, 10)), 
    new Pared(position= game.at(5, 10)), new Pared(position= game.at(6, 10)), new Pared(position= game.at(7, 10)), new Pared(position= game.at(8, 10)), new Pared(position= game.at(9, 10)),
    new Pared(position= game.at(10, 10)), new Pared(position= game.at(11, 10)), new Pared(position= game.at(12, 10)), new Pared(position= game.at(13, 10)), new Pared(position= game.at(2, 8)),
    new Pared(position= game.at(3, 8)), new Pared(position= game.at(4, 8)), new Pared(position= game.at(5, 8)), new Pared(position= game.at(6, 8)),new Pared(position= game.at(7, 8)),
    new Pared(position= game.at(8, 8)), new Pared(position= game.at(8, 1)), new Pared(position= game.at(8, 2)), new Pared(position= game.at(8, 3)), new Pared(position= game.at(8, 4)),  
    new Pared(position= game.at(8, 7)), new Pared(position= game.at(2, 18)), new Pared(position= game.at(3, 18)), new Pared(position= game.at(4, 18)), new Pared(position= game.at(5, 18)),
    new Pared(position= game.at(6, 18)), new Pared(position= game.at(7, 18)), new Pared(position= game.at(8, 18)), new Pared(position= game.at(9, 18)), new Pared(position= game.at(10, 18)),
    new Pared(position= game.at(11, 18)), new Pared(position= game.at(12, 18)), new Pared(position= game.at(13, 18)), new Pared(position= game.at(13, 17)), new Pared(position= game.at(13, 16)),
    new Pared(position= game.at(13, 15)), new Pared(position= game.at(13, 13)), new Pared(position= game.at(13, 12)), new Pared(position= game.at(13, 11)), new Pared(position= game.at(13, 10)),
    new Pared(position= game.at(16, 1)), new Pared(position= game.at(17, 1)), new Pared(position= game.at(18, 1)), new Pared(position= game.at(19, 1)), new Pared(position= game.at(20, 1)),
    new Pared(position= game.at(21, 1)), new Pared(position= game.at(22, 1)), new Pared(position= game.at(23, 1)), new Pared(position= game.at(24, 1)), new Pared(position= game.at(25, 1)), 
    new Pared(position= game.at(26, 1)), new Pared(position= game.at(27, 1)), new Pared(position= game.at(27, 2)), new Pared(position= game.at(27, 3)), new Pared(position= game.at(27, 4)),
    new Pared(position= game.at(27, 5)), new Pared(position= game.at(27, 6)), new Pared(position= game.at(27, 7)), new Pared(position= game.at(27, 8)), new Pared(position= game.at(27, 9)),
    new Pared(position= game.at(27, 10)), new Pared(position= game.at(27, 11)), new Pared(position= game.at(27, 12)), new Pared(position= game.at(27, 13)), new Pared(position= game.at(27, 14)),
    new Pared(position= game.at(27, 15)), new Pared(position= game.at(27, 16)), new Pared(position= game.at(27, 17)), new Pared(position= game.at(27, 18)), new Pared(position= game.at(16, 18)),
    new Pared(position= game.at(17, 18)), new Pared(position= game.at(18, 18)), new Pared(position= game.at(19, 18)), new Pared(position= game.at(20, 18)), new Pared(position= game.at(21, 18)),
    new Pared(position= game.at(22, 18)), new Pared(position= game.at(23, 18)), new Pared(position= game.at(24, 18)), new Pared(position= game.at(25, 18)), new Pared(position= game.at(26, 18)),
    new Pared(position= game.at(16, 2)), new Pared(position= game.at(16, 3)), new Pared(position= game.at(16, 4)), new Pared(position= game.at(16, 5)), new Pared(position= game.at(16, 7)), 
    new Pared(position= game.at(16, 8)), new Pared(position= game.at(16, 9)), new Pared(position= game.at(16, 10)), new Pared(position= game.at(16, 11)), new Pared(position= game.at(16, 12)),
    new Pared(position= game.at(16, 15)), new Pared(position= game.at(16, 16)), new Pared(position= game.at(16, 17)), new Pared(position= game.at(16, 10)), new Pared(position= game.at(17, 10)),
    new Pared(position= game.at(18, 10)), new Pared(position= game.at(19, 10)), new Pared(position= game.at(20, 10)), new Pared(position= game.at(21, 10)), new Pared(position= game.at(22, 10)), 
    new Pared(position= game.at(23, 10)), new Pared(position= game.at(24, 10)), new Pared(position= game.at(25, 10)), new Pared(position= game.at(26, 10)), new Pared(position= game.at(27, 10)),
    new Objeto(position= game.at(24,3)), new Objeto(position= game.at(25,3)), new Objeto(position= game.at(26,3)),new Objeto(position= game.at(24,4)), new Objeto(position= game.at(25,4)), 
    new Objeto(position= game.at(26,4)), new Objeto(position= game.at(24,5)), new Objeto(position= game.at(25,5)), new Objeto(position= game.at(26,5)),new Objeto(position= game.at(5,2)),
    new Objeto(position= game.at(6,2)), new Objeto(position= game.at(5,3)), new Objeto(position= game.at(6,3)), new Objeto(position= game.at(5,4)),
    new Objeto(position= game.at(7,11)), new Objeto(position= game.at(6,11)), new Objeto(position= game.at(5,11)), new Objeto(position= game.at(7,12)), new Objeto(position= game.at(6,12)), 
    new Objeto(position= game.at(5,12)), new Elemento(image="planta.png", position=game.at(18,15)), new Elemento(image="cajon.png", position=game.at(25,16)), new Elemento(image="cajon2.png", position=game.at(20,11)),
    new Elemento(image="computadora.png", position= game.at(23,16)), new Elemento(image="computadora.png", position= game.at(18,8)), new Elemento(image="cajasapiladas.png", position=game.at(25,8)), new Elemento(image="computadora.png", position= game.at(18,8)),
    new Elemento(image="caja.png", position=game.at(21,7)), new Elemento(image="horno.png", position=game.at(6,16)), new Elemento(image="caja.png", position=game.at(10,11)),
    new Elemento(image="mueble.png", position=game.at(3,15)), new Elemento(image="lavaplatos.png", position=game.at(10,15))
   
   
   
]