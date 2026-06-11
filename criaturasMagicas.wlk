class Criatura {
   var rol
   var poderMagico
   const astucia

   method poderMagico() = poderMagico
   method poderOfensivo() = (poderMagico * 10) + rol.extra()

 method esFormidable() = self.esAstuta() || self.esExtraordinaria()

method esExtraordinaria() = rol.esExtraordinario(self)
method esAstuta()

  method cambiarDeRol() {
     rol = rol.siguienteRol()
  }
  
  method perder15Porciento() {
     poderMagico = poderMagico * 0.85
  }

   
}

class Duende inherits Criatura {
  method esAstuta() = false
  override method poderOfensivo() = super() * 1.1
}


class Hada inherits Criatura {
  var kilometros = 2

   method aumentarKm(unValor) {kilometros = (kilometros + unValor).min(25)}

   method esAstuta() = astucia > 50
   override method esExtraordinaria() = super() && kilometros > 10
   
}



object guardian {
   method extra() = 100
   method esExtraordinario(unaCriatura) = unaCriatura.poderMagico() > 50

  method siguienteRol() = new Domador[mascotas= new MascotaMito(edad=1,tieneCuernos=false)]
}

object hechicero {
   method extra() = 0
   method esExtraordinario(unaCriatura) = true
   method siguienteRol() = guardian
}



class Domador {
  const mascotas = []

  method extra() = 150 * (mascotas.conCuernos()) 
  method entrenarMascota(unaMascota) = mascotas.add(unaMascota)

  method todasMascotasVeteranas() =
  mascotas.all({m => m.esVeterana()})
  method esVeterana() = mascotas.all({m => m.edad() > 10})

  method esExtraordinario(unaCriatura) = unaCriatura.poderMagico() >= 15 && unaCriatura.rol.todasMascotasVeteranas()
  
  method siguienteRol() = if (!self.AlMenosUnaConCuernos) self.error("no se puede") return hechicero

  method alMenosUnaConCuernos() = mascotas.any({m => m.Cuernos()})


}

class MascotaMito {
   const property edad 
   const tieneCuernos 
   
   method Cuernos() = tieneCuernos
   method quitarCuernos() {cuernos = false}
   method agregarCuernos() {cuernos = true}
   method conCuernos() {
      mascotas.count({m => m.Cuernos()})
   }
}


class Colonia {
  const criaturas = []

  method atacar(unArea) = if (self.poderOfensivo() > unArea.poderDefensivo()) unArea.serUsurpada(self) else criaturas.forEach({c => c.perder15Porciento()})

  method poderOfensivo() = criaturas.sum({c => c.poderOfensivo()})
  
  method cantCriaturasFormidables() = criaturas.count({c=>c.esFormidable()})
  
}


class Area {
  var colonia = new Colonia()

  method poderDefensivo()
  
  method serUsurpada(unaColonia) {colonia = unaColonia}

}


class Castillo inherits Area {
  override method poderDefensivo() = 200 * colonia.cantCriaturasFormidables()
}
class Claro inherits Area {
  override method poderDefesivo() = 100 + colonia.poderOfensivo()
}
