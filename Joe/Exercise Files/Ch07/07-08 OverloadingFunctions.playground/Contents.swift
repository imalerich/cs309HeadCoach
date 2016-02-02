//: ## Overloading Functions

func processInput(input: String) { }

func processInput(input: Int) { }



func processInput(input: Int) -> String {
  return "\(input)."
}

func processInput(input: Int) -> Int {
  return input * input
}


