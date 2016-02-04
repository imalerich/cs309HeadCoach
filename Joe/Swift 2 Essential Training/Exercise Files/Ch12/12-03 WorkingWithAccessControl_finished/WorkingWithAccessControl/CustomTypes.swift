private let value1 = 1

public let value2 = "Two"

private struct Person {
  
  var name: String
  
}

class CustomClass {
  
  private var title: String {
    return  "CustomClass"
  }
  
  let tuple = (value1, value2)
  
  private func sayHelloWorld() {
    print("Hello, world!")
  }
  
}

class CustomSubclass: CustomClass {
  override var title: String {
    return "CustomSubclass"
  }
  override func sayHelloWorld() {
    print("Hello, world!")
  }
}

private protocol HasTitle {
  
  var title: String { get }
  
}

struct CustomStruct: HasTitle {
  
  let title = "CustomStruct"
  
  private(set) var subtitle = ""
  
}

private func printGreeting(greeting: String, to: Person) {
  print("\(greeting) \(to.name)!")
}

struct AnotherStruct {
  
  var customStruct: CustomStruct
  
  init() {
    customStruct = CustomStruct()
    customStruct.subtitle = "A New Subtitle"
  }
  
}
