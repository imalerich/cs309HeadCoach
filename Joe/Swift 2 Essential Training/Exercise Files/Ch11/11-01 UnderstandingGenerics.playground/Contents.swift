//: ## Understanding Generics

class SomeClass { }

let array: Array<String> = []

let describableArray: Array<protocol<CustomStringConvertible, CustomDebugStringConvertible>> = []

let set: Set<String> = []

let dictionary: Dictionary<Int, String> = [:]

var x = 5
var y = 10

swap(&x, &y)
