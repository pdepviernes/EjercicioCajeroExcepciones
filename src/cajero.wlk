object cajero {

	var cuentas = []
	
	method registrarCuenta(persona, pin) {
		if (self.yaTieneCuenta(persona))
			throw new Exception("Solo se puede tener una cuenta")
		self.verificarPINValido(pin)
		cuentas.add(new Cuenta(titular = persona, pin = pin))
	}
	
	method yaTieneCuenta(persona){
		return cuentas.any{cuenta => cuenta.titular()==persona}
	}
	
	method verificarPINValido(pin){
		self.cuatroElementos(pin)
		self.todosDigitos(pin)
		self.noTodosIguales(pin)
		self.noSecuencia(pin)
	}
	method cuatroElementos(pin){
		if (pin.size()!=4)
			self.pinElegidoEsInvalido()
	}
	
	method pinElegidoEsInvalido() {
		throw new Exception("Elección inválida de PIN")
	}
	
	method todosDigitos(pin){
		if(!pin.all{d=>d>=0 && d<=9 && d.isInteger()})
			self.pinElegidoEsInvalido()
	} 
	method noTodosIguales(pin){
		if(pin.all{d=>d==pin.first()})
			self.pinElegidoEsInvalido()
	} 
	method noSecuencia(pin){
		if ((0..pin.size()-2).
			all{pos=> pin.get(pos+1)==pin.get(pos)+1})
				self.pinElegidoEsInvalido()
	} 
	
	method consultarSaldo(persona, pin) {
		return self.cuentaDe(persona).consultarSaldo(pin)
	}
	
	method extraer(persona, monto, pin) {
		self.cuentaDe(persona).extraer(monto,pin)
	}
	
	method depositar(persona, monto) {
		self.cuentaDe(persona).depositar(monto)
	}
	
	method transferir(origen, monto, destino, pin){
		self.extraer(origen, monto, pin)
		self.cuentaDe(destino).depositar(monto)
	}	
	
	method cuentaDe(persona){
		return cuentas.findOrElse(
			{cuenta => cuenta.titular()==persona},
			{throw new Exception("Persona sin cuenta")})
	}	

}

class Cuenta{
	var saldo = 0
	var pin
	var property titular
	
	method extraer(monto,unPin){
		
		self.validarPin(unPin)
		self.validarSaldoSuficiente(monto)
		
		saldo -= monto
	}
	
	method depositar(monto){
		saldo += monto
	}
	
	method validarSaldoSuficiente(monto){
		if (monto > saldo) 
			throw new Exception("Saldo insuficiente")
	}
	
	
	method validarPin(unPin){
		if (unPin != pin ) 
			throw new Exception("PIN incorrecto")
	}
	
	method consultarSaldo(unPin){
		self.validarPin(unPin)
		
		return saldo
	}
	
	
	
}

class Persona{
	var property nombre
	
}

