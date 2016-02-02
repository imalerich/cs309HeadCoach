//: [Table of Contents](table%20of%20contents)

//: [Previous](@previous)

//: ## Working with Recursive Enumerations

enum Employee {
  
  case None
  indirect case Some(name: String, title: String, manager: Employee?)
  
  static func printOrgChartFromEmployee(employee: Employee) {
    if case let .Some(name, title, manager) = employee {
      print("\(name), \(title)", terminator: "")
      
      if let manager = manager {
        print(" -> ", terminator: "")
        Employee.printOrgChartFromEmployee(manager)
      }
    }
  }
  
}

let desireeLewis = Employee.Some(name: "Desiree Lewis", title: "CEO", manager: .None)
let juanDelToro = Employee.Some(name: "Juan Del Toro", title: "SVP Software Engineering", manager: desireeLewis)
let antoneIrwin = Employee.Some(name: "Antone Irwin", title: "VP Software Technology", manager: juanDelToro)

Employee.printOrgChartFromEmployee(antoneIrwin)

//: [Next](@next)
