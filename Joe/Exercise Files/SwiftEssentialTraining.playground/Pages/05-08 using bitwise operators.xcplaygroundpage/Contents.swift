//: [Table of Contents](table%20of%20contents)

//: [Previous](@previous)

//: ## Using Bitwise Operators

let one = 0b1

let two = one << 1        // 00000010

let four = one << 2       // 00000100

let sixteen = one << 4    // 00010000

let eight = sixteen >> 1  // 00001000

let zero: UInt8 = 0b00000000

~zero // 11111111

let a = 0b111100
let b = 0b001111

a & b // 001100

a | b // 111111

let option1 = 0b0001
let option2 = 0b0010
let option3 = 0b0100

option1 | option2 | option3 // 111

let c = 0b1001
let d = 0b0101

c ^ d // 1100

//: [Next](@next)
