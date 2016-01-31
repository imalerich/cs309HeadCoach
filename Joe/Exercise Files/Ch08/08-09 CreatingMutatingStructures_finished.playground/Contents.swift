//: ## Creating Mutating Structures

struct Counter {
  
  var total = 0
  
  mutating func increment() {
    print("\(++total)")
  }
  
  mutating func reset() {
    self = Counter()
    print(total)
  }
  
}

var counter = Counter()
counter.increment()
counter.reset()
