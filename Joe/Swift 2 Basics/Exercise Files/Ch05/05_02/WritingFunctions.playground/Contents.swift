/*

func sayHello(name: String) -> String {
    return "Hello, \(name)"
}

sayHello("Bob")

func customGreeting(name: String, greeting: String) -> String {
    return "\(greeting), \(name)"
}

customGreeting("Bob", greeting: "Hi")

func sayHelloToFullName(firstName: String, _ lastName: String) -> String {
    return "Hello, \(firstName) \(lastName)"
}

sayHelloToFullName("Bob", "Smith")

*/


//Challenge

func challenge5(age: Int, first: String, last: String) -> Bool{
    if(age >= 18 || (first.characters.count + last.characters.count) > 12){
        return true;
    }
    return false;
}

challenge5(14, first:"Bob", last: "Jones")
challenge5(17, first: "Samantha", last: "Brown")
challenge5(33, first: "Christopher", last: "Washington")

