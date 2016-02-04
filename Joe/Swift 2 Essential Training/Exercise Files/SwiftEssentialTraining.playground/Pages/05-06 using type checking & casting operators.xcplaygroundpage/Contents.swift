//: [Table of Contents](table%20of%20contents)

//: [Previous](@previous)

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

let item1 = arrayOfClassInstances[0]
item1.classAProperty

let item2 = arrayOfClassInstances[1]

item2 is ClassB

let classBInstance = item2 as! ClassB

classBInstance.classBProperty

let classBActingAsClassAInstance = classBInstance as ClassA
//classBActingAsClassAInstance.classBProperty

class ClassC { }

let c = ClassC()

let arrayOfAnyObjects: [AnyObject] = [a, b, c]

let definitelyAClassAInstance = arrayOfAnyObjects[0] as! ClassA

let maybeAClassAInstance = arrayOfAnyObjects[0] as? ClassA

maybeAClassAInstance?.classAProperty

(arrayOfClassInstances[1] as? ClassB)?.classBProperty

//: [Next](@next)
