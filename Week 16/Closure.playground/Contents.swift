import UIKit

var str = "Hello, playground"

func myFunction(){
    print("Message")
}

var printGreeting: (String) -> () = { val in
    print("hi there \(val)")
}

printGreeting("Jim")

var createGreeting: (String, Int) -> (String) = { val, days in
    return "How are you doing after day \(days) of corona, \(val)?"
}

print(createGreeting("Maxine", 2))


var array = [1,2,3,4]

func forEach(array:[Int], closure:(Int) -> () ){
    for num in array{
        closure(num) // calls the closure, passing current number as argument
    }
}

forEach(array: array){ (n) in
    print ("\(n) is such a special number")
}

let closureTest = { (x:Double) -> Int in return Int(x) }

closureTest(2.0)

