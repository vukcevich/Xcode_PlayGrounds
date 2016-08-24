//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


public func parseInt32(bytes:[UInt8], offset:Int)->Int32{
    
    var pointer = UnsafePointer<UInt8>(bytes)
    pointer = pointer.advancedBy(offset)
    
    let iPointer =  UnsafePointer<Int32>(pointer)
    return iPointer.memory
    
}

public func parseFloat32(bytes:[UInt8], offset:Int)->Float32{
    var pointer = UnsafePointer<UInt8>(bytes)
    pointer = pointer.advancedBy(offset)
    
    let fPointer =  UnsafePointer<Float32>(pointer)
    return fPointer.memory
    
}

var bytes:Array<UInt8> = [0x9A, 0x99, 0x99, 0x41] //19.20000

parseFloat32(bytes, offset: 0)

parseInt32(bytes, offset: 0)



//test
var f:Float = 0.0

// Not in Swift 3
 memccpy(&f, bytes, 4, 4) // as per OP.
 
 print("f=\(f)")// f=19.2
 

//memcpy(&f, bytes, 4) /
//print("f=\(f)")// f=19.2


func doubleToByteArray(value: Double) -> [UInt8] {
    let count = sizeof(Double)
    let doubles: [Double] = [value]
    let data = NSData(bytes: doubles, length:sizeofValue(6)) //count)
    var result = [UInt8](count: count, repeatedValue: 0)
    data.getBytes(&result, length: sizeofValue(6) ) //range: NSRange(location: 0, length: sizeofValue(6)))//, length: 6)
    return result
}

var bt = doubleToByteArray(0.25)

var endMarker = NSData(bytes: bt as [UInt8], length: sizeofValue(6))


func binarytotype <T> (value: [UInt8], _: T.Type) -> T
{
    return value.withUnsafeBufferPointer
        {
            return UnsafePointer<T>($0.baseAddress).memory
    }
}

func typetobinary <T> (var value: T) -> [UInt8]
{
    return withUnsafePointer(&value)
    {
        // Array(UnsafeBufferPointer(start: UnsafePointer<UInt8>($0), count: sizeof(T)))
        Array(UnsafeBufferPointer(start: UnsafePointer<UInt8>($0), count: sizeof(T)))
    }
}

let a: Double = 0.25
let b: [UInt8] = typetobinary(a) // -> [0, 0, 0, 0, 0, 0, 208, 63]
let c = binarytotype(b, Double.self) // -> 0.25

let cd = binarytotype(bt, Double.self) // -> 0.25


var float1 : Float = 40.0
let b1: [UInt8] = typetobinary(float1)
let c1 = binarytotype(b1, Float.self)

var double1 : Double = 40.0
let b2: [UInt8] = typetobinary(double1)
let c2 = binarytotype(b1, Float.self)


//Swift 3
/*
func binarytotype <T> (_ value: [UInt8], _ : T.Type) -> T
{
    return value.withUnsafeBufferPointer
        {
            UnsafeRawPointer($0.baseAddress!).load(as: T.self)
    }
}

func typetobinary <T> (_ value: T) -> [UInt8]
{
    var v = value
    let size = MemoryLayout<T>.size
    return withUnsafePointer(to: &v)
    {
        $0.withMemoryRebound(to: UInt8.self, capacity: size)
        {
            Array(UnsafeBufferPointer(start: $0, count: size))
        }
    }
}

let dd: Double = 1.23456             // -> 1.23456
let d = typetobinary(dd)             // -> [56, 50, 143, 252, 193, 192, 243, 63]
let i = binarytotype(d, Double.self) // -> 1.23456
*/


