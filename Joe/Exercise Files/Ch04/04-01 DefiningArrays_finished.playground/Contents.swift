//: ## Defining Arrays

var threeStooges = ["Moe", "Larry", "Curly"]

var inningScores: [Int]
inningScores = []

var testScores = [Double]()

var quizScores: Array<Double> = []
var quarterlyScores = Array<Double>()

var turnstileCounts = Array(count: 20, repeatedValue: 0)

var snowboarderScores = [Double](count: 4, repeatedValue: 10.0)

var arrayOfAny: [Any] = [1, 2.0, "three"]

var someString = "Some string"
var nilString: String? = nil

let arrayOfStrings = [nilString, someString]

var optionalArrayOfStrings: [String]?

var optionalArrayOfOptionalStrings: [String?]?
