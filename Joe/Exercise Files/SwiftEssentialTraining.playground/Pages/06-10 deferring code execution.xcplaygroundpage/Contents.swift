//: [Table of Contents](table%20of%20contents)

//: [Previous](@previous)

//: ## Deferring Code Execution

let allSystemsGo = true

if allSystemsGo {
  defer {
    print("Lift off!")
  }
  
  for i in (1...10).reverse() {
    print(i, terminator: " ")
  }
}

let readyOnSet = true

if readyOnSet {
  defer {
    print("Action!")
  }
  
  defer {
    print("Camera!")
  }
  
  defer {
    print("Lights.")
  }
  
  print("All quiet on set")
}

//: [Next](@next)
