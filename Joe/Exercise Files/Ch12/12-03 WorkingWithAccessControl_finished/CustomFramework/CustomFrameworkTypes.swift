public let value1 = 1

public let value2 = "Two"

public class CustomFrameworkClass {
  
  public let title = "CustomFrameworkClass"
  
  public init() { }
  
}

public struct CustomFrameworkStruct {
    
  public init() { }
  
}

public extension CustomFrameworkStruct {
  
  var title: String {
    return "CustomFrameworkStruct"
  }
  
  private var subtitle: String {
    return "Private subtitle"
  }
  
}

public typealias CFStruct = CustomFrameworkStruct

public enum CustomFrameworkEnum {
  
  case One
  case Two(CFStruct)
  
}
