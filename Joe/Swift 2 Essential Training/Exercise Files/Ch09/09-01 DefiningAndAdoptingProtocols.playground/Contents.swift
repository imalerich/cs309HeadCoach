//: ## Protocols

//: ### Defining & Adopting

import Foundation

protocol DemonstratesProtocol {
  
  var propertyRequirement: String { get set }
  
  init?(x: Int, y: Int)
  
  func methodRequirement(input: String?) -> Int?
  
  subscript(x: Int, y: Int) -> Int { get set }
  
}

protocol SomeOtherProtocol {
  // Requirements
}

protocol DemonstratesProtocolInheritance: DemonstratesProtocol, SomeOtherProtocol {
  // Additional requirements
}


