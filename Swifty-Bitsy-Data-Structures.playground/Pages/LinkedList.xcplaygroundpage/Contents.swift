//: [Previous](@previous)

import Foundation


/*** ===================================================================== ***\
 ** - LINKED LISTS -------------------------------------------------------- **
 * ========================================================================= *
 *      _______________________                                              *
 *  ()=(_______________________)=()              ,-----------------,_        *
 *      |                     |               ,"                      ",     *
 *      |   ~ ~~~~~~~~~~~~~   |             ,'    ,---------------,     `,   *
 *      |               ,----------------------------,          ,----------- *
 *      |   ~ ~~~~~~~~ |                              |        |             *
 *      |               `----------------------------'          `----------- *
 *      |   ~ ~~~~~~~~~~~~~   |            `,    `----------------'     ,'   *
 *      |                     |              `,                      ,'      *
 *      |_____________________|                 `------------------'         *
 *  ()=(_______________________)=()                                          *
 **                                                                         **
 \*** ===================================================================== ***/

/**
 * Next we're going to see how a graph-like structure can help optimize ordered
 * lists of data.
 *
 * Linked lists are a very common data structure that is often used to
 * implement other data structures because of its ability to efficiently add
 * items to the start, middle, and end.
 *
 * The basic idea of a linked list is similar to a graph. You have nodes that
 * point to other nodes. They look sorta like this:
 *
 *     1 -> 2 -> 3 -> 4 -> 5
 *
 * Visualizing them as a JSON-like structure looks like this:
 *
 *     {
 *       value: 1,
 *       next: {
 *         value: 2,
 *         next: {
 *           value: 3,
 *           next: {...}
 *         }
 *       }
 *     }
 */

class LinkedNode<T where T:Equatable> {
    var value : T
    var next : LinkedNode<T>? = nil
    
    init(value v: T, next n: LinkedNode<T>?){
        value = v
        next = n
    }
}

enum LinkedListError: ErrorProtocol {
    case InvalidPosition
}

class LinkedList<T where T:Equatable> {
    
    /**
     * Unlike a graph, a linked list has a single node that starts off the entire
     * chain. This is known as the "head" of the linked list.
     *
     * We're also going to track the length.
     */
    var head : LinkedNode<T>
    var length = 0
    
    init(head h : LinkedNode<T>){
        head = h
    }
    
    /**
     * First we need a way to retrieve a value in a given position.
     *
     * This works differently than normal lists as we can't just jump to the
     * correct position. Instead we need to move through the individual nodes.
     */
    
    func get(_ position: Int) -> LinkedNode<T> {
        // Start with the head of the list.
        var current = head;
        
        // Slide through all of the items using node.next until we reach the
        // specified position.
        for _ in 0...position {
            if let n = current.next {
                current = n
            }
        }
        
        // Return the node we found.
        return current;
    }
    
    /**
     * Next we need a way to add nodes to the specified position.
     *
     * We're going for a generic add method that accepts a value and a position.
     */
    
    func add(value : T, position : Int) throws {
        // First create a node to hold our value.
        let node = LinkedNode(value: value, next: nil);
        
        // We need to have a special case for nodes being inserted at the head.
        // We'll set the "next" field to the current head and then replace it with
        // our new node.
        if (position == 0) {
            node.next = head;
            head = node;
            // If we're adding a node in any other position we need to splice it in
            // between the current node and the previous node.
        }
        else {
            let prev = get(position - 1)
            guard let current = prev.next else {
                throw LinkedListError.InvalidPosition
            }
            // Then insert the new node in between them by setting its "next" field
            // to the current node and updating the previous node's "next" field to
            // the new one.
            node.next = current;
            prev.next = node;
        }
        
        // Finally just increment the length.
        length += 1;
    }
    
    /**
     * The last method we need is a remove method. We're just going to look up a
     * node by its position and splice it out of the chain.
     */
    
    func remove(position : Int) throws{
        // If we're removing the first node we simply need to set the head to the
        // next node in the chain
        if (position == 0) {
            guard let n = head.next else {
                throw LinkedListError.InvalidPosition
            }
            head = n
            // For any other position we need to look up the previous node and set it
            // to the node after the current position.
        } else {
            let prev = get(position - 1)
            guard let nextNext = prev.next?.next else {
                throw LinkedListError.InvalidPosition
            }
            prev.next = nextNext;
        }
        
        // Then we just decrement the length.
        length -= 1;
    }
}


//: [Next](@next)
