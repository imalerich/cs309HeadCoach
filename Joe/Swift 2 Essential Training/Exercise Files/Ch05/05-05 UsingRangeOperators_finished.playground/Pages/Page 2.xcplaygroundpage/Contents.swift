//: [Previous](@previous)

//: ### Strings

var palindrome = "A man a plan a canal Panama"

palindrome.isPalindrome()

let startIndex = palindrome.startIndex.advancedBy(13)

let endIndex = palindrome.endIndex.advancedBy(-8)

let range = startIndex...endIndex

let replacement = "a cat a ham a yak a yam a hat a canal"

palindrome.replaceRange(range, with: replacement)

palindrome.isPalindrome()

//: [Next](@next)
