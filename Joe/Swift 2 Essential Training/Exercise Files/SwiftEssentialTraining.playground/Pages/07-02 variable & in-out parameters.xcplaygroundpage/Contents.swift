//: [Table of Contents](table%20of%20contents)

//: [Previous](@previous)

//: ## Variable & In-Out Parameters

var studentsScore = 76.0
let meanScore = 88.0

@available(*, introduced=1.2, deprecated=2.0, message="Use scaleScore2 instead")
func scaleScore(var score: Double, meanScore: Double, recenteredMean: Double = meanScore * 1.1, deviation: Double = 16.0) {
  let zScore = (score - meanScore) / deviation
  score = recenteredMean + zScore * deviation
  print(score)
}

scaleScore(studentsScore, meanScore: meanScore)
studentsScore

/**
Mutates passed in score, scaling it based on the raw score, mean score, recentered mean score, and standard deviation.
- parameter score: raw score (**original value will be mutated**)
- parameter meanScore: average score
- parameter recenteredMean: average score to recenter to; defaults to 110% of `meanScore`
- parameter deviation: standard deviation; defaults to 16.0
*/
func scaleScore2(inout score: Double, meanScore: Double, recenteredMean: Double = meanScore * 1.1, deviation: Double = 16.0) {
  guard score > 0 && meanScore > 0 && recenteredMean > 0 && deviation > 0 else {
    print("All input values must be greater than 0.")
    return
  }
  let zScore = (score - meanScore) / deviation
  score = recenteredMean + zScore * deviation
  print(score)
}

scaleScore2(&studentsScore, meanScore: meanScore)
studentsScore

//: [Next](@next)
