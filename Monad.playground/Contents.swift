//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


let num = ["odds", "evens"]

let dict = [
            "odds" : [1, 3, 5],
            "evens" : [2, 4, 6]
            ]

var n1 = num.flatMap(dict[$0])
    
    n1.flatMap($0)
    .sort()
    .map { $0 * 2 }