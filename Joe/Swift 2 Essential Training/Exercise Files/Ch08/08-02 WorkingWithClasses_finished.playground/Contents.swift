//: ## Working with Classes

import UIKit

protocol Protocol1 { }
protocol Protocol2 { }

class MyClass {
  // Properties, initializers, deinitializers, methods, subscripts
}

class MySubclass: MyClass, Protocol1, Protocol2 {
  // Properties, initializers, deinitializers, methods, subscripts
}

class MotorVehicle {
  
  // Type properties
  static var count = 0
  
  // Instance properties
  var numberOfWheels: Int?
  var passengerCapacity = 4
  let topSpeedMph: Int
  
  var bodyColor = "black" {
    willSet {
      print("Will be painted \(newValue)")
    }
    
    didSet {
      print("Was previously \(oldValue)")
    }
  }
  
  var manufacturerName = ""
  var model = ""
  var makeAndModel: (make: String, model: String) {
    get {
      return (manufacturerName, model)
    }
    
    set(newMakeAndModel) {
      manufacturerName = newMakeAndModel.make
      model = newMakeAndModel.model
    }
  }
  
  var topSpeedKph: Int {
    return Int(Double(topSpeedMph) * 1.60934)
  }
  
  lazy var fuelEfficiencyMpg = {
    (arc4random_uniform(3) + 2) * 15
  }()
  
  var engineRunning = false
  var currentSpeedMph = 0
  
  // Initializers
  init(topSpeedMph: Int, bodyColor: String) {
    self.topSpeedMph = topSpeedMph
    self.bodyColor = bodyColor
    print("MotorVehicle count: \(++MotorVehicle.count)")
  }
  
  convenience init(topSpeedMph: Int) {
    self.init(topSpeedMph: topSpeedMph, bodyColor: "blue")
  }
  
  convenience init(topSpeedMph: Int, numberOfWheels: Int) {
    self.init(topSpeedMph: topSpeedMph)
    self.numberOfWheels = numberOfWheels
  }
  
  convenience init?(manufacturerName: String?, topSpeedMph: Int, bodyColor: String) {
    self.init(topSpeedMph: topSpeedMph, bodyColor: bodyColor)
    
    guard let name = manufacturerName where name.isEmpty == false else {
      return nil
    }
    
    self.manufacturerName = name
  }
  
  // Deinitializer
  deinit {
    print("MotorVehicle count: \(--MotorVehicle.count)")
  }
  
  // Type methods
  static func newMotorVehicleOfMake(make: String, model: String, topSpeedMph: Int, bodyColor: String, passengerCapacity: Int, numberOfWheels: Int? = nil) -> MotorVehicle {
    let motorVehicle = MotorVehicle(manufacturerName: make, topSpeedMph: topSpeedMph, bodyColor: bodyColor)!
    motorVehicle.model = model
    motorVehicle.passengerCapacity = passengerCapacity
    motorVehicle.numberOfWheels = numberOfWheels
    return motorVehicle
  }
  
  // Instance methods
  func startEngine() {
    guard engineRunning == false else { return }
    engineRunning = true
    print("Vroom!")
  }
  
  func adjustSpeedToMph(mph: Int) {
    guard engineRunning && currentSpeedMph != mph else { return }
    let increment = (mph - currentSpeedMph) / 5
    
    for _ in currentSpeedMph.stride(through: mph, by: increment) {
      print("\(currentSpeedMph)...", terminator: "")
      currentSpeedMph += increment
    }
    
    currentSpeedMph = mph
    print("Now traveling \(currentSpeedMph) mph")
  }
  
}

let bugattiVeyronSuperSport = MotorVehicle(topSpeedMph: 267)

let granTurismo = MotorVehicle(manufacturerName: "Maserati", topSpeedMph: 185, bodyColor: "blue")!
granTurismo.numberOfWheels = 4
granTurismo.topSpeedKph
granTurismo.bodyColor = "red"
granTurismo.fuelEfficiencyMpg = 65
granTurismo.fuelEfficiencyMpg
granTurismo.startEngine()
granTurismo.adjustSpeedToMph(60)
granTurismo.adjustSpeedToMph(89)
granTurismo.adjustSpeedToMph(0)

var landspeeder: MotorVehicle? = MotorVehicle.newMotorVehicleOfMake("SoroSuub", model: "X-34", topSpeedMph: 155, bodyColor: "sandyBrown", passengerCapacity: 2)
landspeeder = nil
