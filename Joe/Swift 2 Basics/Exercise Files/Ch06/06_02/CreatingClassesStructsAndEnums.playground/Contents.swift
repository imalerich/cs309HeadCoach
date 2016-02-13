class MyClass {
    var a : Int
    
    init(initialValue: Int) {
        a = initialValue
    }
    
    func classMethod() -> String {
        return "Return value"
    }
    
}

var cl = MyClass(initialValue: 15)
cl.a
cl.a = 10
cl.classMethod()


struct MyStruct {
    var a = 4
    
    init(initialValue: Int) {
        a = initialValue
    }
    
    func structMethod() -> String {
        return "Return value"
    }
}

var st = MyStruct(initialValue: 12)
st.a
st.a = 16
st.structMethod()

enum MyEnum {
    case Value1, Value2, Value3
    
    static var testValues = ["Test1","Test2","Test3"]
    
    init() {
        self = .Value2
    }
    
    func returnMyValueInStringForm() -> String {
        switch(self) {
        case .Value1:
            return MyEnum.testValues[0]
        case .Value2:
            return MyEnum.testValues[1]
        case .Value3:
            return MyEnum.testValues[2]
        }
    }
}

var en = MyEnum()
en.returnMyValueInStringForm()


