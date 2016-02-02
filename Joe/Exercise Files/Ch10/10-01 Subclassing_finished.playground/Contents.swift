//: ## Subclassing

class Vehicle {
  
  let passengerCapacity: Int
  
  init(passengerCapacity: Int) {
    self.passengerCapacity = passengerCapacity
  }
  
  func adjustSpeedToMph(mph: Int) {
    fatalError("Do not call \(__FUNCTION__) on an instance of this class. Override in subclass instead.")
  }
  
}

let vehicle = Vehicle(passengerCapacity: 1)
//vehicle.adjustSpeedToMph(10)

class LandVehicle: Vehicle {
  
  var numberOfWheels = 4
  var topSpeedMph = 0
  
  override init(passengerCapacity: Int) {
    super.init(passengerCapacity: passengerCapacity)
  }
  
  convenience init(numberOfWheels: Int) {
    self.init(passengerCapacity: 4)
    self.numberOfWheels = numberOfWheels
  }
  
}

class Cycle: LandVehicle {
  
  var numberOfPedalingPassengers = 0
  
  override var topSpeedMph: Int {
    get {
      let ratio = Double(numberOfPedalingPassengers) / Double(passengerCapacity)
      
      switch (numberOfPedalingPassengers, passengerCapacity) {
      case let (current, capacity) where (1...6).contains(capacity) && current > 0:
        return Int(20.0 * ratio)
      case let (current, capacity) where capacity > 6 && current > 0:
        return Int(8.0 * ratio)
      default:
        return 0
      }
    }
    
    set {
      fatalError("\(__FUNCTION__) is not settable.")
    }
  }
  
  override func adjustSpeedToMph(mph: Int) {
    print("...Now traveling \(min(topSpeedMph, mph)) mph")
  }
  
}

class MotorVehicle: LandVehicle {
  
  let cc: Int
  final let vin: String
  
  required init(cc: Int, passengerCapacity: Int, numberOfWheels: Int, vin: String) {
    self.cc = cc
    self.vin = vin
    super.init(passengerCapacity: passengerCapacity)
    self.numberOfWheels = numberOfWheels
  }
  
  deinit {
    print("MotorVehicle will be deallocated")
  }
  
  final func printVIN() {
    print("Vehicle Identification Number: \(vin)")
  }
  
}

final class MotorCycle: MotorVehicle {
  
  required init(cc: Int, passengerCapacity: Int, numberOfWheels: Int, vin: String) {
    super.init(cc: cc, passengerCapacity: 2, numberOfWheels: 2, vin: vin)
  }
  
  deinit {
    print("MotorCycle will be deallocated")
  }
  
}

//class MiniBike: MotorCycle { }

let pedalPartyBike = Cycle(passengerCapacity: 20)
pedalPartyBike.numberOfPedalingPassengers = 16
pedalPartyBike.topSpeedMph
pedalPartyBike.adjustSpeedToMph(100)

var hdEvolution: MotorCycle? = MotorCycle(cc: 1340, passengerCapacity: 2, numberOfWheels: 2, vin: "1J8...")
hdEvolution = nil
