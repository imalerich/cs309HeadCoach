//: [Table of Contents](table%20of%20contents)

//: [Previous](@previous)

//: # Chapter 11 - Understanding Generics

//: ## Understanding Generics

class SomeClass { }

let array: Array<SomeClass> = []

let describableArray: Array<protocol<CustomStringConvertible, CustomDebugStringConvertible>> = []

let set: Set<String> = []

let dictionary: Dictionary<Int, String> = [:]

var x = 5
var y = 10

swap(&x, &y)

//: [Next](@next)
