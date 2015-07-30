import Foundation
import SpriteKit

public class Blockly: SKSpriteNode {
    
    /**
     Nodes are always formed in pairs.
    
     Agressive Node   |   Passive Node
     -----------------+------------------
     - prev           |   - next
     - parentBy       |   - childBy

     Only update Agressive nod avoid infinite recursion.
     Update prev instead of next for the following reason: For a linked list to sumbit all its relevant contents, it does not matter what previous node of some unwanted node is, since it will never be reached as long as it is not the next node of any wanted node. Hence when a unwanted node is detached from the previous node, the previous node must always set its next node to nil.
     */
    
    public weak var prev: Blockly? {
        /** 
         - Reset ParentHeight
         - Unlink from Parent
         - Reset Parent Position
         */
        willSet {
            self.prev?.head.parentBy?.size.height -= totalHeight
            self.prev?.next = nil
            self.prev?.head.parentBy?.position.y += totalHeight/2
        }
        
        /**
         - Link to new parent
         - Update parent height
         - Update parent position
         */
        didSet {
            self.prev?.next = self
            self.prev?.head.parentBy?.size.height += totalHeight
            self.prev?.head.parentBy?.position.y -= totalHeight/2
        }
    }
    
    public weak var next: Blockly?
    
    
    /**
     Parent Node is always positioned on the left of the child node by default
     Before changing parent node, remove self from parent node
     After changing parent node, set self as child node of parent node
     */
    public weak var parentBy: Blockly? {
        willSet {
            let translation = max(0, totalHeight/2 - (parentBy == nil ? totalHeight/2 : self.parentBy!.originalSize.height/2))
            self.parentBy?.size.height = max(originalSize.height, (childBy == nil ? 0 : childBy!.totalHeight))
            self.parentBy?.childBy = nil
            self.parentBy?.position.y += translation
        }
        didSet {
            let translation = max(0, totalHeight/2 - (parentBy == nil ? totalHeight/2 : self.parentBy!.originalSize.height/2))
            self.parentBy?.size.height = max(originalSize.height, (childBy == nil ? 0 : childBy!.totalHeight))
            self.parentBy?.childBy = self
            self.parentBy?.position.y -= translation
        }
    }
    
    /**
     Child Node is always positioned on the bottom right of the parent node by default.
     Each node can only have ond child node. However by appending nodes to the child node, a linked list of "children" can be created
     */
    public weak var childBy: Blockly?
    
    public var nextSnappingEnabled = true       /** Allow nodes to snap to its bottom, enabled by default */
    public var prevSnappingEnabled = true       /** Allow nodes to snap to its top, enabled by default */
    public var parentSnappingEnabled = false    /** Allow nodes to snap to its right becoming a child, disabled by default */
    
    public var lockPrev = false
    
    static let defaultSize = CGSize(width: 100, height: 80)     /** Default size of a Blockly */
    static let defaultColor = UIColor.blackColor()              /** Default color of a Blockly */
    
    public var originalSize = CGSize(width: 100, height: 80) {
        didSet { self.size = originalSize }
    }
    
    /**
     After updating position, adjust positions of all the children and nodes linked after
     */
    override public var position: CGPoint {
        didSet {
            self.updateNextPosition()
            self.updateChildPosition()
        }
    }
        
    public var topGravity    : CGFloat = 30     /* Top Stickiness */
    public var bottomGravity : CGFloat = 30     /* Bottom Stickiness */
    public var parentGravity : CGFloat = 30   /* Parent Stickiness */
    
    /** Returns the number of nodes linked after */
    public var count: Int { return next == nil ? 0 : next!.count + 1 }
    
    /** Return the total height of all the nodes linked after including itself */
    public var totalHeight: CGFloat { return next == nil ? size.height : next!.totalHeight + size.height }
    
    /** Return the first node of its node chain */
    public var head: Blockly { return prev == nil ? self : prev!.head }
    
    public var root: Blockly { return  (prev == nil || !lockPrev) ? self : prev!.root }
    
    /** Blockly Builder */
    public typealias BlocklyBuilderClosure = (Blockly) -> Void
    public static func build(builderClosure: BlocklyBuilderClosure) -> Blockly {
        let blockly = Blockly()
        blockly.size = defaultSize
        blockly.color = defaultColor
        builderClosure(blockly)
        return blockly
    }
    
    /**
     If top of the blockly is sticky and previous node is not locked, update previous node
     */
    func updatePrev() {
        if prevSnappingEnabled && !lockPrev {
            var neighbour = self.scene?.nodeAtPoint(CGPointMake(position.x, position.y + size.height/2 + topGravity))
            if let neighbour = neighbour as? Blockly where
                (neighbour.next == nil || neighbour.next == self) &&
                (prev == nil || prev == neighbour) {
                prev = neighbour
            } else {
                prev = nil
            }
        }
    }
    
    func updateNext() {
        if nextSnappingEnabled && !(next != nil && next!.lockPrev) {
            var neighbour = self.scene?.nodeAtPoint(CGPointMake(position.x, position.y - size.height/2 - bottomGravity))
            if let neighbour = neighbour as? Blockly where
                (neighbour.prev == nil || neighbour.prev == self) &&
                (next == nil || next == neighbour) {
                neighbour.prev = self
            } else {
                next = nil
            }
        }
    }
    
    func updateParent() {
        if parentSnappingEnabled {
            var neighbour = self.scene?.nodeAtPoint(CGPointMake(position.x - size.width/2 - parentGravity, position.y))
            if let neighbour = neighbour as? Blockly where
                (neighbour.childBy == nil || neighbour.childBy == self) &&
                (parentBy == nil || parentBy == neighbour) {
                parentBy = neighbour
            } else {
                parentBy = nil
            }
        }
    }
    
    /**
     Snap to the bottom of the previous node or right of the parent node
     Note that parent node has higher priority than previous node
     It also auto update the position of all the passvive nodes linked
    
     Must not call the following function or  it will cause infinite loop:
     - snapToNeighbour on prev
     - snapToNeighbour on parentBy
     */
    public func snapToNeighbour() {
        if let parentBy = parentBy {
            position = CGPointMake(
                parentBy.position.x + parentBy.size.width/2 + size.width/2,                                 /* Stick to the right of the parent node */
                parentBy.position.y + parentBy.size.height/2 - size.height/2 /* Stick to the top */
            )
        } else if let prev = prev {
            position = CGPointMake(
                prev.position.x - prev.size.width/2 + size.width/2,     /* Same x */
                prev.position.y - prev.size.height/2 - size.height/2    /* Stick to the bottom of the previous node */
            )
        } else if let next = next {
            position = CGPointMake(
                next.position.x - next.size.width/2 + size.width/2,
                next.position.y + next.size.height/2 + size.height/2
            )
        }
//        updateNextPosition()
//        updateChildPosition()
    }
    
    
    /** Update the positions of all the nodes linked after */
    public func updateNextPosition() { next?.snapToNeighbour() }
    
    /** Update the positions of the child */
    public func updateChildPosition() { childBy?.snapToNeighbour() }
    
    /**
     Update positions and size due to changes in children
     @param translationY, self will translate by translationY unit
    
     Order is important, size must always be changed before position
     */
    public func updateFromChild(translationY: CGFloat) {
        self.size.height = max(originalSize.height, (childBy == nil ? 0 : childBy!.totalHeight))
        self.position.y += translationY
    }

}
