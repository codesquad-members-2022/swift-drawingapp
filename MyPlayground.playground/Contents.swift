import UIKit

var greeting = "Hello, playground"
class Person {
    var name: String = "Kai"
 
    var alias: String {
        get {
            return self.name + " 바보"
        }
        set(name) {
            self.name = name + "은 별명에서 지어진 이름"
        }
    }
}


var p1 = Person()
print(p1.alias) //Kai 바보

p1.alias = "SUKA"
print(p1.name) // SUKA 은 별명에서 지어진 이름
