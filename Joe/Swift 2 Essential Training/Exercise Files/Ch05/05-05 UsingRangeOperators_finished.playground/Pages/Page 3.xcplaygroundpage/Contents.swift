//: [Previous](@previous)

//: ### Arrays

var fibonacciNumbers = [1, 3, 6, 10, 15, 21] // Not!

let rangeToReplace = fibonacciNumbers.startIndex.successor()..<fibonacciNumbers.endIndex.predecessor()

let replacement = [1, 2, 3, 5, 8, 13]

fibonacciNumbers.replaceRange(rangeToReplace, with: replacement)

print(fibonacciNumbers)

