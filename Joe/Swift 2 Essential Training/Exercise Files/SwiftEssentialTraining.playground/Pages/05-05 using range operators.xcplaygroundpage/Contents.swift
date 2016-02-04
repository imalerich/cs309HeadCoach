//: [Table of Contents](table%20of%20contents)

//: [Previous](@previous)

//: ## Using Range Operators

let rangeA = 0..<10

let rangeB = 0...10

0...10 == 0..<11

//: ### Strings

var palindrome = "A man a plan a canal Panama"

palindrome.isPalindrome()

let startIndex = palindrome.startIndex.advancedBy(13)

let endIndex = palindrome.endIndex.advancedBy(-8)

let range = startIndex...endIndex

let replacementString = "a cat a ham a yak a yam a hat a canal"

palindrome.replaceRange(range, with: replacementString)

palindrome.isPalindrome()

//: ### Arrays

var fibonacciNumbers = [1, 3, 6, 10, 15, 21] // Not!

let rangeToReplace = fibonacciNumbers.startIndex.successor()..<fibonacciNumbers.endIndex.predecessor()

let replacementArray = [1, 2, 3, 5, 8, 13]

fibonacciNumbers.replaceRange(rangeToReplace, with: replacementArray)

print(fibonacciNumbers)

//: [Next](@next)
