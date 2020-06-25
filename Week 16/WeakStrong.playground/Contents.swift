import UIKit

class Person {
    var appartment:Appartment?
    let name: String
    
    init(name:String){
        self.name = name
    }
    deinit{
        print("\(name) was terminated")
    }
}

class Appartment {
    weak var person:Person?
    let unit:String
    
    init(unit:String){
        self.unit = unit
    }
    
    deinit {
        print("\(unit) was terminated")
    }
}

var person1:Person? = Person(name: "Anna")
var appartment1:Appartment? = Appartment(unit: "104")

person1?.appartment = appartment1
appartment1?.person = person1

person1     = nil
appartment1 = nil
