//: ## Deferring Code Execution
let allSystemsGo = true

if allSystemsGo {
  for i in (1...10).reverse() {
    print(i, terminator: " ")
  }
}

let readyOnSet = true

if readyOnSet {
  print("All quiet on set")
}
