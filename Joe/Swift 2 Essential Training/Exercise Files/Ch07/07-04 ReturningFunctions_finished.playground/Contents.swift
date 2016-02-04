//: ## Returning Functions

func getHelloWorldSayer() -> () -> () {
  func sayHelloWorld() {
    print("Hello, world")
  }
  
  return sayHelloWorld
}

let helloWorldSayer = getHelloWorldSayer()

helloWorldSayer()

func addDoubles(doubles: Double...) -> Double {
  return doubles.reduce(0, combine: +)
}

func getDoubleAdder() -> (Double...) -> Double {
  return addDoubles
}

let doubleAdder = getDoubleAdder()

doubleAdder(6.4, 12.8, 25.6)
