//: Playground - noun: a place where people can play

import Cocoa

// Playground - noun: a place where people can play
// Consider this your Main class, basically the Stage
// Note: The code below is for OSX Playground, not iOS

// this imports higher level APIs like Starling
import SpriteKit
import XCPlayground

// our main logic inside this class
class GameScene: SKScene {
    
    // properties initialization
    // note that the spriteNode property below is not initialized
    // we initialize it through the init initializer below
    var spriteNode: SKSpriteNode
    var i = 0.0
    
    // this is our initializer, called once when the scene is created
    // we do our initialization/setup here
    override init(size: CGSize){
        
        // let's grab an image, like [Embed] in AS3, results in image data like BitmapData
        // let is to declare a constant, var a variable
        // note that we don't type things, you actually can to resolve ambiguity sometimes
        // but it is inferred by default and does not cause performance issues to not statically type
        let sprite = NSImage(contentsOfFile:"/Users/marijanvukcevich/Documents/Adium.png")
        
        // let's create a bitmap, like Bitmap in AS3
        let myTexture = SKTexture(image: sprite!)
        
        // let's wrap it inside a node
        spriteNode = SKSpriteNode(texture: myTexture)
        
        // we position it, we could scale it, etc.
        spriteNode.position = CGPoint (x: 250, y: 250)
        
        // we complete the initialization by initializating the superclass
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // this gets triggered automtically when the scene is presented by the view
    // similar to Event.ADDED_TO_STAGE
    override func didMoveToView(view: SKView) {
        
        // let's add it to the display list
        self.addChild(spriteNode)
    }
    
    // we override update, which is like an Event.ENTER_FRAME or advanceTime in Starling
    override func update(currentTime: CFTimeInterval) {
        i += 0.1
        // oscillation with sin, like Math.sin
        let osc = 1.5 + sin(CDouble(i))
        // let's scale it
        spriteNode.setScale(CGFloat(osc))
        // we could have retrieved spriteNode also with the code below, similar to getChildAt(0)
        //let node = self.children[0] as SKSpriteNode
    }
}

// we create our scene (from our GameScene above), like a main canvas
let scene = GameScene(size: CGSize(width: 400, height: 400))

// we need a view
let view = SKView(frame: NSRect(x: 0, y: 0, width: 400, height: 400))

// we link both
view.presentScene(scene)

// display it, XCPShowView is a global function that paints the final scene
//XCPShowView("result", view: view) //depricated
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true
XCPlaygroundPage.currentPage.liveView = view
//XCPlaygroundPage.currentPage.captureValue(view, withIdentifier: "Width") //depricated

