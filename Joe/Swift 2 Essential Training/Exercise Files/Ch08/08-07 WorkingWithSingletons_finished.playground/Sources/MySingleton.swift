/// Access shared instance via `sharedInstance` type property, e.g., `MySingleton.sharedInstance`
public class MySingleton {
  
  public static let sharedInstance = MySingleton()
  public var title = ""
  
  private init() { } // private is default in a playground
  
}