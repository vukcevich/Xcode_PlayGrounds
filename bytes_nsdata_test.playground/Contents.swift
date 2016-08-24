//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var float1 : Float = 40.0
let data = NSData(bytes: &float1, length: sizeofValue(float1))
print(data) // <00002042>

//var float2 : Float = 0
data.getBytes(&float1, length: sizeofValue(float1))
//print(float2) // 40.0

func decimalStringToUInt8Array(decimalString:String) -> [UInt8] {
    
    // Convert input string into array of Int digits
    let digits = Array(arrayLiteral: decimalString).map{ Int(String($0))!}
    let numdigits = digits.count
    
    // Array to hold the result, in reverse order
    var bytes:[UInt8] = []
    
    // Convert array of digits into array of Int values each
    // representing 6 digits of the original number.  Six digits
    // was chosen to work on 32-bit and 64-bit systems.
    // Compute length of first number.  It will be less than 6 if
    // there aren't a multiple of 6 digits in the number.
    var ints:[Int] = Array(count: (numdigits + 5)/6, repeatedValue: 0)
    var rem = numdigits % 6
    if rem == 0 {
        rem = 6
    }
    var index = 0
    var accum = 0
    for digit in digits {
        accum = accum * 10 + digit
        if --rem == 0 {
            rem = 6
            ints[index++] = accum
            accum = 0
        }
    }
    
    // Repeatedly divide value by 256, accumulating the remainders.
    // Repeat until original number is zero
    while ints.count > 0 {
        var carry = 0
        for (index, value) in ints.enumerate() {
            var total = carry * 1000000 + value
            carry = total % 256
            total /= 256
            ints[index] = total
        }
        
        bytes.append(UInt8(truncatingBitPattern: carry))
        
        // Remove leading Ints that have become zero.
        while ints.count > 0 && ints[0] == 0 {
            ints.removeAtIndex(0)
        }
    }
    
    // Reverse the array and return it
    return bytes.reverse() //(bytes)
}

print(decimalStringToUInt8Array("0"))         // prints "[0]"
print(decimalStringToUInt8Array("255"))       // prints "[255]"
print(decimalStringToUInt8Array("256"))       // prints "[1,0]"
print(decimalStringToUInt8Array("1024"))      // prints "[4,0]"
print(decimalStringToUInt8Array("16777216"))  // prints "[1,0,0,0]"
print(decimalStringToUInt8Array("1025"))  // prints "[1,0,0,0]"


func uInt8ArrayToDecimalString(uint8array:[UInt8]) -> String {
    
    // For efficiency in calculation, combine 3 bytes into one Int.
    let numvalues = uint8array.count
    var ints:[Int] = Array(count: (numvalues + 2)/3, repeatedValue: 0)
    var rem = numvalues % 3
    if rem == 0 {
        rem = 3
    }
    var index = 0
    var accum = 0
    for value in uint8array {
        accum = accum * 256 + Int(value)
        if --rem == 0 {
            rem = 3
            ints[index++] = accum
            accum = 0
        }
    }
    
    // Array to hold the result, in reverse order
    var digits:[Int] = []
    
    // Repeatedly divide value by 10, accumulating the remainders.
    // Repeat until original number is zero
    while ints.count > 0 {
        var carry = 0
        for (index, value) in ints.enumerate() {
            var total = carry * 256 * 256 * 256 + value
            carry = total % 10
            total /= 10
            ints[index] = total
        }
        
        digits.append(carry)
        
        // Remove leading Ints that have become zero.
        while ints.count > 0 && ints[0] == 0 {
            ints.removeAtIndex(0)
        }
    }
    
    // Reverse the digits array, convert them to String, and join them
    return  join("", digits.reverse().map{String($0)})
}
