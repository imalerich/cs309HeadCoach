/**
Has **`addressee`** property equal to "world," and
**`sayHello()`** and **`sayHelloTo(addressee:)`** methods
*/
public struct Bas {
  public var addressee = "world"
  
  public init() { }
  
  public func sayHello() {
    print("Hello, \(addressee)!")
  }
  
  public func sayHelloTo(addressee: String) {
    print("Hello, \(addressee)!")
  }
}
