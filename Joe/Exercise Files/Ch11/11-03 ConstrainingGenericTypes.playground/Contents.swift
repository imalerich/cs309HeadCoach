//: ## Constraining Generic Types

protocol Edible {
  
  var name: String { get }
  var caloriesPerServing: Int { get }
  
}

typealias Describable = CustomStringConvertible

struct Ingredient: Edible, Describable {
  
  let name: String
  var caloriesPerServing: Int
  
  var description: String {
    return "\(name) - \(caloriesPerServing) calories per serving"
  }
  
  init(_ name: String, _ caloriesPerServing: Int) {
    self.name = name
    self.caloriesPerServing = caloriesPerServing
  }
  
}

let chocolateChips = Ingredient("Chocolate chips", 201)

let driedFruit = Ingredient("Dried fruit", 85)

let granola = Ingredient("Granola", 113)

let mixedNuts = Ingredient("Mixed nuts", 219)

let miniPretzels = Ingredient("Mini pretzels", 110)

struct TrailMix: Describable {
  
  var description: String {
    var totalCaloriesPerServing = 0.0
    var combinedDescription = ""
    
    return "Trail mix, calories per serving: \(totalCaloriesPerServing)\n  Ingredients:\n\(combinedDescription)"
  }
  
}


