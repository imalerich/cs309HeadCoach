//: [Table of Contents](table%20of%20contents)

//: [Previous](@previous)

//: # Chapter 5 - Operators

//: ## Using Arithmetic Operators

//: ### Numeric Literals & Values

4 + 2
4 - 2
4 * 2
4 / 2

1.2 + 3.4
1.2 - 3.4
1.2 * 3.4
1.2 / 3.4

var a = 1
a++
a
a--
a

var b = 3.14
print(--b)
print(b++)
b

let c = 4.1 + 2
4.1 - 2
4.1 * 2
4.1 / 2

let fourPointOne: Float = 4.1
let d = fourPointOne / 2

let two = 2
let e = 4.1 / Double(two)

10 / 3
let f = 10.0 / 3

var g = 10
g += 4
g -= 4
g *= 4
g /= 4

10 % 3
-10 % 3
10 % -3
98 % 10.5

//: ### Overflow

var h: UInt8 = UInt8.max
//h += 1

h &+ 1

var i: Int8 = Int8.min
i &- 1

var j: UInt8 = 200
j = j &* 2
55 + 1 + 144

//: [Next](@next)
