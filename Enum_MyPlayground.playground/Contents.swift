//: Playground - noun: a place where people can play

import UIKit
import Foundation
import QuartzCore

var str = "Hello, playground"

/*
enum ColorName : String {
    case Black, Silver, Gray, White, Maroon, Red, Purple, Fuchsia, Green, Lime, Olive, Yellow, Navy, Blue, Teal, Aqua
}
*/
 
enum CSSColor {
    case Named(ColorName)
    case RGB(UInt8, UInt8, UInt8)
}

extension CSSColor: CustomStringConvertible {
    var description: String {
        switch self {
            case .Named(let colorName):
                return colorName.rawValue
            case .RGB(let red, let green, let blue):
            return String(format: "#%02X%02X%02X", red,green,blue)
        }
    }
}

extension CSSColor {
    enum ColorName : String {
        case Black, Silver, Gray, White, Maroon, Red, Purple, Fuchsia, Green, Lime, Olive, Yellow, Navy, Blue, Teal, Aqua
    }
}

extension CSSColor {
    init(gray: UInt8) {
        self = .RGB(gray, gray, gray)
    }
}

let color1 = CSSColor.Named(.Red)
let color2 = CSSColor.RGB(0xAA, 0xAA, 0xAA)
print("color1 = \(color1), color2 = \(color2)") // prints color1 = Red, color2 = #AAAAAA


let color3 = CSSColor(gray: 0xaa)
print(color3)  //  prints #AAAAAA

enum Math {
    static let pi = 3.1415926535897932384626433832795028841971694
}

Math.pi




protocol Drawable {
    func draw(context:DrawingContext)
}

protocol DrawingContext {
    func draw(circle: Circle)
}
struct Circle: Drawable {
    var storkeWidth = 5
    var strokeColor = CSSColor.Named(.Red)
    var fillColor = CSSColor.Named(.Yellow)
    var center = (x: 80.0, y: 160.0)
    var radius = 60.0
    
    //Addopting the Drawable protocol
    func draw(context:DrawingContext) {
        context.draw(self)
    }
    
}


var a = Circle()
a.radius = 60.0
var b = a
a.radius = 1000.0

