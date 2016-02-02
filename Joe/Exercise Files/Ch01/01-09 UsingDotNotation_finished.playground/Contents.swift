//: ## Using Dot Notation

var foo = Foo()
var bar = Bar()
var bas = Bas()

print(bas.addressee)
bas.addressee = "viewer"

bas.sayHello()

bas.sayHelloTo(bas.addressee)

foo
  .bar
  .bas
  .sayHello()
