//: ## Extending Protocols

protocol Vehicular {
  
  var passengerCapacity: Int { get }
  
}



protocol Paintable {
  
  var primaryBodyColor: String { get set }
  var secondaryBodyColors: [String]? { get set }
    
}



protocol Wheeled {
  
  var numberOfWheels: Int { get }
  
}



protocol Motorized {
  
  var engineSizeCc: Int { get }
  
}


