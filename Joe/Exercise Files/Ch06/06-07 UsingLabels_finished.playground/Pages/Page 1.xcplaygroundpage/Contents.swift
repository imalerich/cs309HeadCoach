//: ## Using Labels

var i = 0
let hello = "Hello, playground!"

start: do {
  i++
  
  do {
    print(hello)
    
    if i < 3 {
      continue start
    }
  }
}

//: [Next](@next)
