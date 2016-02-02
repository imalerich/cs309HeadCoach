import UIKit
import CustomFramework

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let customClass = CustomClass()
//    print(customClass.title)
//    customClass.sayHelloWorld()
    let customSubclass = CustomSubclass()
    print(customSubclass.title)
    customSubclass.sayHelloWorld()
    
    _ = customClass.tuple.0
    
    let customFrameworkClass = CustomFrameworkClass()
    _ = customFrameworkClass.title
    
    _ = value1
    _ = value2
    
    let customStruct = CustomStruct()
    print(customStruct.subtitle)
//    customStruct.subtitle = "Hello"
    
    let customFrameworkStruct = CustomFrameworkStruct()
    print(customFrameworkStruct.title)
//    print(customFrameworkStruct.subtitle)
    
    _ = CustomFrameworkEnum.Two(CFStruct())
    
  }
  
}
