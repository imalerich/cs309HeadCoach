//: [Table of Contents](table%20of%20contents)

//: [Previous](@previous)

//: ## Adding Comments

/*
// Single-line comment

var someVariable = "..."

func someFunction() {
/* A multi-line comment
nested in a function
*/
}
*/

//: ### Delimiters

//: Single-line delimiter

/*: Text on this line not displayed in rendered markup
Block delimiter

## Header 2
### Header 3

> "Block quote"

* Milk
* Bread
* Bananas

----

1. **Learn Swift**
2. Develop an _awesome_ app
3. Retire

`print("Hello, world!")`
*/

//: ### Links & Images

//: [Swift blog](https://developer.apple.com/swift/)

//: ![Swift logo](https://developer.apple.com/assets/elements/icons/128x128/swift.png "The Swift logo")

//: ![Betty](Betty.png "Betty")

//: ### Quick Help Comments

/// A Quick Help comment
func someComplexFunction() { }

/**
Another Quick Help comment
- seealso: `someComplexFunction`
*/
func anotherComplexFunction() { }

//: [Next](@next)
