//: ## Optional Chaining

let hank = Person(firstName: "Hank")

let mike = Person(firstName: "Mike")

let greg = Person(firstName: "Greg")

let marcia = Person(firstName: "Marcia", lastName: "Brady")

marcia.birthday = "8/5/1956"

mike.children = [greg, marcia]

hank.children = [mike]


