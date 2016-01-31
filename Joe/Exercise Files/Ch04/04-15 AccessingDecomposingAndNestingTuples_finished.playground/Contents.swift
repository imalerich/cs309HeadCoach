//: ## Accessing, Decomposing & Nesting Tuples

let httpStatus200 = (200, "OK")

var playerScores: ([Int], firstName: String, lastName: String?) = ([134_000, 128_500, 156_250], firstName: "Scott", lastName: "Gardner")

let highScore = playerScores.0.maxElement()!

print("\(playerScores.firstName) achieved a high score of \(highScore).")

let (scores, firstName, lastName) = playerScores

let averageScore = scores.reduce(0, combine: +) / scores.count

print("\(firstName) achieved an average score of \(averageScore).")

let (httpStatusCode, _) = httpStatus200

var anotherScore = (100, (firstName: "Scott", lastName: "Gardner"))

let (theScore, name) = anotherScore

name.firstName
