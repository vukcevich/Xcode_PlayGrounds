//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

protocol PackableType { }

extension Int : PackableType { }
extension UInt8 : PackableType { }
extension UInt16 : PackableType { }
extension UInt32 : PackableType { }
extension UInt64 : PackableType { }
// More integer types ...

extension Double : PackableType { }
extension Float : PackableType { }
// More floating point types ...

typealias Byte = UInt8

enum ByteOrder {
    case BigEndian
    case LittleEndian
    
    static var hostByteOrder = ByteOrder()
    
    init() {
        // self = (UInt(littleEndian: 1) == 1) ? .LittleEndian : .BigEndian
        self = (UInt(bigEndian: 1) == 1) ? .BigEndian : .LittleEndian
    }
}

extension PackableType {
    
    func pack(byteOrder byteOrder: ByteOrder) -> [Byte] {
        var value = self
        let valueByteArray = withUnsafePointer(&value) {
            Array(UnsafeBufferPointer(start: UnsafePointer<Byte>($0), count: sizeofValue(value)))
        }
        return (byteOrder == ByteOrder.hostByteOrder) ? valueByteArray : valueByteArray.reverse()
    }
    
    static func unpack(valueByteArray: [Byte], byteOrder: ByteOrder) -> Self {
        let bytes = (byteOrder == ByteOrder.hostByteOrder) ? valueByteArray : valueByteArray.reverse()
        return bytes.withUnsafeBufferPointer {
            return UnsafePointer($0.baseAddress).memory
        }
    }
}


let bytes = 12.34.pack(byteOrder: .LittleEndian)
let double = Double.unpack(bytes, byteOrder: .LittleEndian)

//let bytes = 12.34.pack(byteOrder: .BigEndian)
//let double = Double.unpack(bytes, byteOrder: .BigEndian)