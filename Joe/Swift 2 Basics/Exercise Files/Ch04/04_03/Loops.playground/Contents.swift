/*
var i = 0

while(true) {
    i += 1
    if (i >= 10) {
        break
    }
}

i = 0

while(i < 10) {
    i += 1
}

//i = 0

repeat {
    i += 1
} while(i < 10)



for (var j = 0; j < 20; j += 1) {
    j
}

let myArray = [1,5,10]

for a in myArray {
    a
}


for (var index = 1; index <= 15; index += 1) {
    index
}

for index2 in 1...15 {
    index2
}
*/
var arr : [Int] = Array()

for index in 1...100{
    arr.append(index * index)
}

for (var i = 0; i < 100; i++){
    if(arr[i] % 3 == 0){
        print(arr[i])
    }
}
