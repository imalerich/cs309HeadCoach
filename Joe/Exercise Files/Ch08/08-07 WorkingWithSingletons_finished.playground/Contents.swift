//: ## Working with Singletons

//let mySingleton = MySingleton()

let mySingletonA = MySingleton.sharedInstance
mySingletonA.title = "A"

let mySingletonB = MySingleton.sharedInstance
mySingletonB.title = "B"

print(mySingletonA.title)
print(mySingletonB.title)
