//: # Using Type Checking & Casting Operators

class ClassA {
  var classAProperty = 867_5309
}

class ClassB: ClassA {
  var classBProperty = "Stay classy San Diego"
}

let a = ClassA()
let b = ClassB()

let arrayOfClassInstances = [a, b]
