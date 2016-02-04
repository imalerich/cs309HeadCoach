import Foundation

public class Person {
  
  public var firstName: String
  public var lastName: String?
  
  public var name: String {
    return lastName != nil ? "\(firstName) \(lastName!)" : "\(firstName)"
  }
  
  public init(firstName: String, lastName: String? = nil) {
    self.firstName = firstName
    self.lastName = lastName
  }
  
}
