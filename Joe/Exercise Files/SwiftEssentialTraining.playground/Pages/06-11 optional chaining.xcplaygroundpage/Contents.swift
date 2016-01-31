//: [Table of Contents](table%20of%20contents)

//: [Previous](@previous)

//: ## Optional Chaining

let hank = Person(firstName: "Hank")

let mike = Person(firstName: "Mike")

let greg = Person(firstName: "Greg")

let marcia = Person(firstName: "Marcia", lastName: "Brady")

marcia.birthday = "8/5/1956"

mike.children = [greg, marcia]

hank.children = [mike]

if let hanksChildren = hank.children {
  if let mike = hanksChildren.first {
    if let mikesChildren = mike.children {
      let marcia = mikesChildren[1]
      
      if let marciasAge = marcia.spelledOutAge() {
        print("\(marcia.name) is \(marciasAge) years old now!")
      }
    }
  }
}

if let marciasAge = hank.children?.first?.children?[1].spelledOutAge() {
  print("\(marcia.name) is \(marciasAge) years old now!")
}

let age = hank.children?.first?.children?[1].spelledOutAge()

let mikeBrady = hank.children?[0]

//: [Next](@next)
