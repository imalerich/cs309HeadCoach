import Foundation

protocol Shape {
    func calculateArea() -> Double
}

class Quadrilateral : Shape {
    var sideLength1, sideLength2, sideLength3, sideLength4 : Double
    
    init() {
        sideLength1 = 0
        sideLength2 = 0
        sideLength3 = 0
        sideLength4 = 0
    }
    
    func calculateArea() -> Double {
        return -1
    }
}

class Square : Quadrilateral {
    init(withSideLength sl : Double) {
        super.init()
        sideLength1 = sl
        sideLength2 = sl
        sideLength3 = sl
        sideLength4 = sl
    }
    
    override func calculateArea() -> Double {
        return sideLength1 * sideLength1
    }
}

class Rectangle : Quadrilateral {
    init(withSideLengthA sl : Double, andSideLengthB sl2 : Double) {
        super.init()
        sideLength1 = sl
        sideLength2 = sl2
        sideLength3 = sl
        sideLength4 = sl2
    }
    
    override func calculateArea() -> Double {
        return sideLength1 * sideLength2
    }
}

class Circle : Shape {
    var radius : Double
    
    init(withRadius r : Double) {
        radius = r
    }
    
    func calculateArea() -> Double {
        return M_1_PI * radius * radius
    }
}

class Triangle : Shape {
    var type : TriangleType
    var sideLength : Double
    var sideLength2 : Double?
    
    init(equilateralWithSideLength sl : Double) {
        type = .Equilateral
        sideLength = sl
    }
    
    init(rightWithSideLengthA sl : Double, andSideLengthB sl2 : Double) {
        type = .Right
        sideLength = sl
        sideLength2 = sl2
    }
    
    enum TriangleType {
        case Equilateral, Right
    }
    
    func calculateArea() -> Double {
        switch(type) {
        case .Equilateral:
            return (sqrt(3)/4.0)*(sideLength * sideLength)
        case .Right:
            return (sideLength * sideLength2!) / 2.0
        }
    }
}

var rightT = Triangle(rightWithSideLengthA: 3, andSideLengthB: 4)
rightT.calculateArea()

var equiT = Triangle(equilateralWithSideLength: 3)
equiT.calculateArea()

var circle = Circle(withRadius: 10)
circle.calculateArea()

var square = Square(withSideLength: 4)
square.calculateArea()

var rectangle = Rectangle(withSideLengthA: 4, andSideLengthB: 6)
rectangle.calculateArea()






