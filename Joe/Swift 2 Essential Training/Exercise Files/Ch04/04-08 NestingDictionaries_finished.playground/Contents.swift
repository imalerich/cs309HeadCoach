//: ## Nesting Dictionaries

var bostonMarathonResults: [Int: [String: String]] = [
  1: [
    "name": "Desisa",
    "country": "ETH",
    "finishingTime": "2:09:17",
  ]
]

let firstPlaceName = bostonMarathonResults[1]?["name"]
