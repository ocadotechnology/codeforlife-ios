import Foundation
import SpriteKit

public class Blockly: SKSpriteNode {
    
    /**
     Only update either next or prev to avoid infinite recursion.
     Update prev instead of next for the following reason: For a linked list to sumbit all its relevant contents, it does not matter what previous node of some unwanted node is, since it will never be reached as long as it is not the next node of any wanted node. Hence when a unwanted node is detached from the previous node, the previous node must always set its next node to nil.
     */
    public weak var prev: Blockly? { willSet { prev?.next = (newValue == prev) ? self : nil } }
    public weak var next: Blockly?
    public weak var parentBy: Blockly? { willSet { parentBy?.childBy = (newValue == parentBy) ? self : nil } }
    public weak var childBy: Blockly?
    
    public var nextSnappingEnabled = true
    public var prevSnappingEnabled = true
    public var parentSnappingEnabled = false
    public var sisterSnappingEnabled = false
    
    static let defaultSize = CGSize(width: 100, height: 80)
    static let defaultColor = UIColor.blackColor()
        
    public var topGravity    : CGFloat = 20
    public var bottomGravity : CGFloat = 20
    public var leftGravity   : CGFloat = 20
    
    public var prevPos: CGPoint?
    
    public var count: Int {
        return next == nil ? 0 : next!.count + 1
    }
    
    public static func build(builderClosure: (Blockly) -> Void) -> Blockly {
        let blockly = Blockly()
        blockly.size = defaultSize
        blockly.color = defaultColor
        builderClosure(blockly)
        return blockly
    }
    
    func updatePrev() {
        if prevSnappingEnabled {
            var neighbour = self.scene?.nodeAtPoint(CGPointMake(position.x, position.y + size.height/2 + topGravity))
            if let neighbour = neighbour as? Blockly where
                (neighbour.next == nil || neighbour.next == self) &&
                (prev == nil || prev == neighbour) {
                prev = neighbour
                neighbour.next = self
            } else {
                prev = nil
            }
        }
    }
    
    func updateNext() {
        if nextSnappingEnabled {
            var neighbour = self.scene?.nodeAtPoint(CGPointMake(position.x, position.y - size.height/2 - bottomGravity))
            if let neighbour = neighbour as? Blockly where
                (neighbour.prev == nil || neighbour.prev == self) &&
                (next == nil || next == neighbour) {
                next = neighbour
                neighbour.prev = self
            } else {
                next = nil
            }
        }
    }
    
    func updateParent() {
        if parentSnappingEnabled {
            var neighbour = self.scene?.nodeAtPoint(CGPointMake(position.x - size.width/2 - leftGravity, position.y))
            if let neighbour = neighbour as? Blockly where
                (neighbour.childBy == nil || neighbour.childBy == self) &&
                    (parentBy == nil || parentBy == neighbour) {
                        parentBy = neighbour
                        neighbour.childBy = self
            } else {
                parentBy = nil
            }
        }
    }
    
    /**
     Snap to the bottom of the previous node or right of the parent node
     Note that parent node has higher priority than previous node
     It also auto update the position of all the nodes linked after
     */
    func snapToNeighbour() {
        if let parentBy = parentBy {
           position = CGPointMake(parentBy.position.x + parentBy.size.width/2 + size.width/2, parentBy.position.y)
        } else if let prev = prev {
            position = CGPointMake(prev.position.x, prev.position.y - size.height)
        }
        updateNextPosition()
        updateChildPosition()
    }
    
    /**
     Update the positions of all the nodes linked after
     */
    func updateNextPosition() { next?.snapToNeighbour() }
    
    /**
     Update the positions of the child
     */
    func updateChildPosition() { childBy?.snapToNeighbour() }

}
