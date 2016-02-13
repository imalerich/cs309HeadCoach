
var myArray : [Int] = Array()

for i in 1...100 {
    myArray.append(i * i)
}

for item in myArray {
    if (item % 3 == 0) {
        print(item)
    }
}