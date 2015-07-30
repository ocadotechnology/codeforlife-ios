import Foundation
import SpriteKit

public class Blockly: UIView {
    
    /**
     Nodes are always formed in pairs.
    
     Agressive Node   |   Passive Node
     -----------------+------------------
     - prev           |   - next
     - parentBy       |   - childBy

     Only update Agressive nod avoid infinite recursion.
     Update prev instead of next for the following reason: For a linked list to sumbit all its relevant contents, it does not matter what previous node of some unwanted node is, since it will never be reached as long as it is not the next node of any wanted node. Hence when a unwanted node is detached from the previous node, the previous node must always set its next node to nil.
    
     Recommended Guidelines:
     1. Always update node reference before changing the position of the nodes
            - Updating position will also change child and next position, which may cause child and next unable to detach
     2. Avoid using willSet and didSet on both parties of a node pair
            - May cause infinite loop in recursion
     */
    
    
    public weak var next: Blockly?
    public weak var prev: Blockly? {
        willSet { self.prev?.updateNext(nil) }
        didSet { self.prev?.updateNext(self) }
    }
    
    private func updateNext(newNext: Blockly?) {
        let oldParentHeight = newNext == nil ?
                                head.totalHeight :
                                max(head.totalHeight, head.parentBy == nil ? 0 : head.parentBy!.originalSize.height)
        self.next = newNext
        let newParentHeight = max(head.totalHeight, head.parentBy == nil ? 0 : head.parentBy!.originalSize.height)
        head.parentBy?.frame.size.height = newParentHeight
        head.parentBy?.center.y += (oldParentHeight - newParentHeight)/2
    }
    
    
    public weak var childBy: Blockly?
    public weak var parentBy: Blockly? {
        willSet { self.parentBy?.updateChild(nil) }
        didSet { self.parentBy?.updateChild(self) }
    }

    private func updateChild(newChildBy: Blockly?) {
        let translation = max(0, childBy == nil ? 0 : childBy!.totalHeight/2 - originalSize.height/2)
        self.childBy = newChildBy
        self.frame.size.height = max(originalSize.height, childBy == nil ? 0 : childBy!.totalHeight)
        self.center.y += childBy == nil ? translation : -translation
    }
    
    public var nextSnappingEnabled = true       /** Allow nodes to snap to its bottom, enabled by default */
    public var prevSnappingEnabled = true       /** Allow nodes to snap to its top, enabled by default */
    public var parentSnappingEnabled = false    /** Allow nodes to snap to its right becoming a child, disabled by default */
    
    public var lockPrev = false
    
    static let defaultSize = CGSize(width: 100, height: 80)     /** Default size of a Blockly */
    static let defaultColor = UIColor.blackColor()              /** Default color of a Blockly */
    
    public var originalSize = CGSize(width: 100, height: 80) {
        didSet { self.frame.size = originalSize }
    }
    
    /**
     After updating position, adjust positions of all the children and nodes linked after
     */
    override public var center: CGPoint {
        didSet { updateNextAndChildPosition() }
    }
    
    private func updateNextAndChildPosition() {
        next?.snapToNeighbour()
        childBy?.snapToNeighbour()
    }
        
    public var topGravity    : CGFloat = 30     /* Top Stickiness */
    public var bottomGravity : CGFloat = 30     /* Bottom Stickiness */
    public var parentGravity : CGFloat = 30   /* Parent Stickiness */
    
    /** Returns the number of nodes linked after */
    public var count: Int { return next == nil ? 0 : next!.count + 1 }
    
    /** Return the total height of all the nodes linked after including itself */
    public var totalHeight: CGFloat { return next == nil ? frame.height : next!.totalHeight + frame.height }
    
    /** Return the first node of its node chain */
    public var head: Blockly { return prev == nil ? self : prev!.head }
    
    public var root: Blockly { return  (prev == nil || !lockPrev) ? self : prev!.root }
    
    /** Blockly Builder */
    public typealias BlocklyBuilderClosure = (Blockly) -> Void
    public static func build(builderClosure: BlocklyBuilderClosure) -> Blockly {
        let blockly = Blockly()
        blockly.frame.size = defaultSize
        blockly.backgroundColor = defaultColor
        builderClosure(blockly)
        return blockly
    }
    
    /**
     If top of the blockly is sticky and previous node is not locked, update previous node
     */
    func updatePrev() {
        if prevSnappingEnabled && !lockPrev {
            let positionToFind = CGPointMake(center.x, center.y + frame.height/2 + topGravity)
            if let neighbour = discoverNeighbour(positionToFind) where
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
            let positionToFind = CGPointMake(center.x, center.y - frame.height/2 - bottomGravity)
            if let neighbour = discoverNeighbour(positionToFind) where
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
            let positionToFind = CGPointMake(center.x - frame.width/2 - parentGravity, center.y)
            if let neighbour = discoverNeighbour(positionToFind) where
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
            center = CGPointMake(
                parentBy.center.x + parentBy.frame.width/2 + frame.width/2,                                 /* Stick to the right of the parent node */
                parentBy.center.y + parentBy.frame.height/2 - frame.height/2 /* Stick to the top */
            )
        } else if let prev = prev {
            center = CGPointMake(
                prev.center.x - prev.frame.width/2 + frame.width/2,     /* Same x */
                prev.center.y - prev.frame.height/2 - frame.height/2    /* Stick to the bottom of the previous node */
            )
        } else if let next = next {
            center = CGPointMake(
                next.center.x - next.frame.width/2 + frame.width/2,
                next.center.y + next.frame.height/2 + frame.height/2
            )
        }
    }
    
    public func discoverNeighbour(pos: CGPoint) -> Blockly? {
        for subview in superview!.subviews {
            if let subview = subview as? Blockly where CGRectContainsPoint(subview.frame, pos) {
                return subview
            }
        }
        return nil
    }

}
