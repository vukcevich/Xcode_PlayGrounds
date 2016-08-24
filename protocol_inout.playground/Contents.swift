//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


/*
    If you only work with instances of a class and the function only modifies properties of the object pointed-to by the instance, then you don't need an inout-parameter at all, since classes are reference types. You only need to mark the protocol as a "class protocol":
*/

//Mark: added ':class' to protocol SomeProtocol
protocol SomeProtocol : class {
    var name : String { get set }
}
class SomeClass: SomeProtocol {
    var name : String = ""
}

func doSomethingWith(someVar: SomeProtocol) {
    // Modify the object:
    someVar.name = "modfied"
}

var someGlobalVar = SomeClass()
doSomethingWith(someGlobalVar)
print(someGlobalVar.name) // "modified"



//Mark: make function generic - doSomethingWith2<T: SomeProtocol2>
protocol SomeProtocol2  {
    var name : String { get set }
}
class SomeClass2: SomeProtocol2 {
    var name : String = ""
}

func doSomethingWith2<T: SomeProtocol2>(inout someVar: T) {
    // Modify the object:
    someVar.name = "new modfied"
}

var someGlobalVar2 = SomeClass2()
doSomethingWith2(&someGlobalVar2) //passing pointer
print(someGlobalVar2.name) // "new modified"



/*
 Explained third: 
 
 When you assign a SomeClass instance to a variable while declaring, the variable type is inferred to be SomeClass. The same as writing:
 private var someGlobalVar: SomeClass = SomeClass()
 
 However, when passing to an inout parameter, the function can assign another instance to that variable, e.g.
 private func doSomethingWith(inout someVar: SomeProtocol) {
 someVar = OtherClass()
 }
 
 Now you have a type mismatch. The error you are seeing is Swift preventing you getting a similar problem.
 
 In other words: if you are passing a variable to a function and you know that the function can assign any instance adopting SomeProtocol to that variable, you have to use a variable that can actually hold any instance adopting SomeProtocol:
 
 private var someGlobalVar: SomeProtocol
 */



//Mark: add protocol type to variable someGlobalVar3 ':SomeProtocol3'
protocol SomeProtocol3 {
    var name : String { get set }
}
class SomeClass3: SomeProtocol3 {
    var name : String = ""
}

func doSomethingWith3(inout someVar: SomeProtocol3) {
    // Modify the object:
    someVar.name = "Third modfied"
}

var someGlobalVar3: SomeProtocol3 = SomeClass3()
doSomethingWith3(&someGlobalVar3)
print(someGlobalVar3.name) // "third modified"
