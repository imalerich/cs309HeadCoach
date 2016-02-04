//: ## Nesting Arrays

var threeStooges = ["Moe", "Larry", "Curly"]

var famousGroupsOfThree = [
  threeStooges,
  ["Huey", "Dewey", "Louie"],
  ["Athos", "Porthos", "Aramis"],
  ["Jack", "Chrissy", "Jane"]
]

let threeMusketeers = famousGroupsOfThree[2]

let jack = famousGroupsOfThree[3][0]

famousGroupsOfThree[3][2] = "Janet"

print(famousGroupsOfThree.flatMap( { $0 } ))
