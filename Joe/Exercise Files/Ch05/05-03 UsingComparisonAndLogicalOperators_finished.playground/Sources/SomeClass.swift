public func ==(lhs: SomeClass, rhs: SomeClass) -> Bool {
  return lhs.title == rhs.title
}
  
public class SomeClass {
  public var title = "SomeClass"
  public init() { }
}