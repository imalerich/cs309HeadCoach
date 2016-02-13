/*


class Employee {
    var yearsWorked : Double = 0
    var hasStockOptions : Bool = false
    var currentStatus : EmployeeStatus = .Active
    
    enum EmployeeStatus {
        case Active, Vacation, LeaveOfAbsence, Temp, Retired
    }
}

protocol ExecutiveMember {
    var bonusAmount : Int {
        get
    }
    func returnFullTitle() -> String
}

class CEO : Employee, ExecutiveMember {
    override init() {
        super.init()
        hasStockOptions = true
    }
    
    var bonusAmount : Int {
        return 10000
    }
    
    func returnFullTitle() -> String {
        return "Chief Executive Officer"
    }
}

class CFO : Employee {
    override init() {
        super.init()
        hasStockOptions = true
    }
    
    var bonusAmount : Int {
        return 5000
    }
    
    func returnFullTitle() -> String {
        return "Chief Financial Officer"
    }
}

class Worker : Employee {
    
}

class TempEmployee: Employee {
    override init() {
        super.init()
        currentStatus = .Temp
    }
}


let ceo = CEO()
ceo.yearsWorked = 25
ceo.bonusAmount
ceo.returnFullTitle()
ceo.currentStatus = .LeaveOfAbsence
ceo.currentStatus

let cfo = CFO()
cfo.bonusAmount
cfo.returnFullTitle()
cfo.currentStatus

let worker = Worker()
worker.currentStatus

let temp = TempEmployee()
temp.currentStatus
//fails
//temp.returnFullTitle()

*/

import Foundation

protocol Shape{
    func calculateArea() -> Double
}

class Quadrilateral: Shape{
    var sideLength1, sideLength2: Double
    
    init(){
        sideLength1 = 0
        sideLength2 = 0
    }
    
    func calculateArea() -> Double {
        return -1
    }
}

class Square : Quadrilateral{
    init(sl: Double){
        super.init()
        sideLength1 = sl
        sideLength2 = sl
    }
    override func calculateArea() -> Double {
        return sideLength1 * sideLength1
    }
}

class Rectangle : Quadrilateral{
    init(sl1: Double, sl2: Double){
        super.init()
        sideLength1 = sl1
        sideLength2 = sl2
    }
    override func calculateArea() -> Double {
        return sideLength1 * sideLength2
    }
}


class Circle : Shape{
    var radius : Double
    init(r: Double){
        radius = r
    }
    func calculateArea() -> Double {
        return M_1_PI * radius * radius
    }
}

class Triangle : Shape{
    var type : TriangleType
    var sideLength : Double
    var sideLength2 : Double?
    
    init(equilateralWithSideLength sl : Double){
        type = .Equilateral
        sideLength = sl
    }
    
    init(rightWithSideLengthA sl : Double, andSideLenthB sl2 : Double){
        type = .Right
        sideLength = sl
        sideLength2 = sl2
    }
    
    enum TriangleType{
        case Equilateral, Right
    }
    
    func calculateArea() -> Double {
        switch(type){
        case .Equilateral:
            return (sqrt(3)/4) * (sideLength * sideLength)
        case .Right:
            return (sideLength * sideLength2!) / 2.0
        }
    }
}



