//: Playground - noun: a place where people can play

import UIKit
import Foundation

var str = "Hello, playground"

var array: [[Int]] = [[1,2,3],[4,5,6],[7,8,9]]
for row in 0...2 {
    for column in 0...2 {
        print("column: \(column) row: \(row) value:\(array[column][row])")
        
    }
}

var matrix:[[Int]] = [[Int]](count:3, repeatedValue:[Int](count: 3, repeatedValue:0))

var matrix2:[[Int]] = [[Int]]() //creates an empty matrix
//var row = [Int]() //fill this row
var row = [0,1,0]
matrix2.append(row) //add this row
var row2 = [0,1,0]
matrix2.append(row2) //add this row


class Array2DTyped<T>{
    
    var cols:Int, rows:Int
    var matrix:[T]
    
    init(cols:Int, rows:Int, defaultValue:T){
        self.cols = cols
        self.rows = rows
        matrix = Array(count:cols*rows,repeatedValue:defaultValue)
    }
    
    subscript(col:Int, row:Int) -> T {
        get{
            return matrix[cols * row + col]
        }
        set{
            matrix[cols * row + col] = newValue
        }
    }

    
    func colCount() -> Int {
        return self.cols
    }
    
    func rowCount() -> Int {
        return self.rows
    }
}


var mat = Array2DTyped.init(cols: 3, rows: 3, defaultValue: Double())

mat[0,0] = 1.0
mat[0,1] = 2.0
mat[1,0] = 3.0
mat[1,1] = 5.0

print("\(mat[0,0])")
print("\(mat[0,1])")
print("\(mat[1,0])")
print("\(mat[1,1])")


