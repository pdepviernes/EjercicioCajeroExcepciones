object cajero {

	var cuentas = []
	
	method registrarCuentaPara(persona, pin) {
		var nuevaCuenta = new Cuenta(apoderado = persona, pin = pin)
		cuentas.add(nuevaCuenta)
	}
	
	method consultarSaldoDe(unaPersona, unPin) {
		var cuenta = self.cuentaDe(unaPersona)
		return cuenta.consultarSaldo(unPin)
	}
	
	method extraer(persona, monto, pin) {
		var cuenta = self.cuentaDe(persona)
		cuenta.extraer(monto,pin)
	}
	
	method depositar(persona, monto, pin) {
		var cuenta = self.cuentaDe(persona)
		cuenta.depositar(monto,pin)
	}
	
	method transferir(unaPersona,unMonto,otraPersona, unPin){
		self.extraer(unaPersona, unMonto, unPin)
		
		var cuentaDestino = self.cuentaDe(otraPersona)
		cuentaDestino.recibir(unMonto)
	}	
	
	method cuentaDe(persona){
		return cuentas.filter{cuenta => cuenta.esDe(persona)}.first()
	}	

}

class Cuenta{
	var saldo = 0
	var pin
	var apoderado
	
	method esPinValido(unPin){
		return pin == unPin
	}
	
	method esDe(unaPersona){
		return apoderado == unaPersona
	}
	
	method extraer(unMonto,unPin){
		
		self.validarPin(unPin)
		self.validarSaldoSuficienteParaExtaer(unMonto)
		
		saldo -= unMonto
	}
	
	method depositar(unMonto, unPin){
		self.validarPin(unPin)
		
		self.recibir(unMonto)
		
	}
	
	method recibir(unMonto){
		saldo += unMonto
	}
	
	method validarSaldoSuficienteParaExtaer(unMonto){
		if (unMonto > saldo) throw new Exception("Saldo Insuficiente")
	}
	
	
	method validarPin(unPin){
		if (unPin != pin ) throw new Exception("PIN Incorrecto")
	}
	
	method consultarSaldo(unPin){
		self.validarPin(unPin)
		
		return saldo
	}
	
	
	
}

class Persona{
	var property nombre
}

