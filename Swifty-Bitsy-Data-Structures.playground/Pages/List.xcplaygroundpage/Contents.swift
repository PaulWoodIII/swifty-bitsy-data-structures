//: [Previous](@previous)

import Foundation

/*:
 To demonstrate the raw interaction between memory and a data structure we're
 going to first implement a list.
 
 A list is a representation of an ordered sequence of values where the same
 value may appear many times.
 */

/*:
 Swift doesn't allow up to create arrays of any size so lets me a `Node` to store either an elemnt or not, but still have allocated more than enough space in the memory.
 */
struct ListNode<T where T:Comparable> {
    var element : T?
    func isEmpty() -> Bool {
        if element != nil {
            return false
        }
        return true
    }
}

extension ListNode where T:CustomStringConvertible  {
    internal var description: String {
        get {
            if let element = element {
                return element.description
            }
            else {
                return "Empty node"
            }
        }
    }
}

class List<T where T:Comparable>  {
    
/*:

 
 Note that we want to store the length separately because in real life the "memory" doesn't have a length you can read from. So this is a bit of an exersize so you can see the extra logic an Array in Swift is hiding from you
 
 
 */
    var memory : Array<ListNode<T>> = {
        let node = ListNode<T>()
        let array = Array<ListNode<T>>(repeating: node, count: 100)
        return array
    }()
    var length = 0

    
/*:
 First we need a way to retrieve data from our list.
 
 With a plain list, you have very fast memory access because you keep track of the address directly.
 
 List access is constant O(1) - "AWESOME!!"
 */

    func get(_ address : Int) -> T? {
        return memory[address].element
    }
    
/*:
 Because lists have an order you can insert stuff at the start, middle,
 or end of them.
 
 For our implementation we're going to focus on adding and removing values
 at the start or end of our list with these four methods:
 
 - Push    - Add value to the end
 - Pop     - Remove value from the end
 - Unshift - Add value to the start
 - Shift   - Remove value from the start
 
 Starting with "push" we need a way to add items to the end of the list.
 
 It is as simple as adding a value in the address after the end of our
 list. Because we store the length this is easy to calculate. We just add
 the value and increment our length.
 
 Pushing an item to the end of a list is constant O(1) - "AWESOME!!"
 */
    func push(_ value : T) {
        var node = ListNode<T>()
        node.element = value
        memory[length] = node
        length = length + 1
    }
    
/*:
 Next we need a way to "pop" items off of the end of our list.
 
 Similar to push all we need to do is remove the value at the address at the end of our list. Then just decrement length.
 
 Popping an item from the end of a list is constant O(1) - "AWESOME!!"
 */
    
    func pop() -> T? {
        // Don't do anything if we don't have any items.
        if (length == 0) {
            return nil
        }
        
        // Get the last value, stop storing it, and return it.
        let value = memory[length-1]
        length -= 1;
        
        // Also return the value so it can be used.
        return value.element;
    }
    
/*:
     
 "push" and "pop" both operate on the end of a list, and overall are pretty simple operations because they don't need to be concerned with the rest of the list.
 
 Let's see what happens when we operate on the begining of the list with "unshift" and "shift".

 In order to add a new item at the beginning of our list, we need to make room for our value at the start by sliding all of the values over by one.
     
    [a, b, c, d, e]
     0  1  2  3  4
      ⬊  ⬊  ⬊  ⬊  ⬊
     1  2  3  4  5
    [x, a, b, c, d, e]
 
 In order to slide all of the items over we need to iterate over each one moving the prev value over.
 
 Because we have to iterate over every single item in the list: Unshifting an item to the start of a list is linear O(N) - "OKAY."
 */
    
    func unshift(_ value : T) {
        // Store the value we are going to add to the start.
        var node = ListNode<T>()
        node.element = value
        var previous = node
        
        // Iterate through each item...
        for address in 0 ..< length {
            // replacing the "current" value with the "previous" value and storing the
            // "current" value for the next iteration.
            let current = memory[address]
            memory[address] = previous;
            previous = current;
        }
        
        // Add the last item in a new position at the end of the list.
        memory[length] = previous;
        length += 1;
    }
    
/*:
 Finally, we need to write a shift function to move in the opposite
 direction.
 
 We delete the first value and then slide through every single item in the
 list to move it down one address.
 
      [x, a, b, c, d, e]
       1  2  3  4  5
      ⬋  ⬋  ⬋  ⬋  ⬋
     0  1  2  3  4
    [a, b, c, d, e]
 
 Shifting an item from the start of a list is linear O(N) - "OKAY."
 */
    
    func shift() -> T? {
        // Don't do anything if we don't have any items.
        if (length == 0) {
            return nil
        }
        
        let value = memory[0];
        
        // Iterate through each item...
        for address in 0 ..< length {
            // and replace them with the next item in the list.
            memory[address] = memory[address + 1];
        }
        
        // Delete the last item since it is now in the previous address.
        length -= 1;
        
        return value.element;
    }
}

extension List where T:CustomStringConvertible  {
    internal var description: String {
        get {
            var returnVal = ""
            for i in 0...length {
                returnVal = memory[i].description
            }
            returnVal.appendingFormat(", LENGTH: %d", length)
            return returnVal
        }
    }
}

var list = List<Int>();
//:Exersize it
list.push(1)
list.unshift(2)
debugPrint(list)

let foo = list.get(1)

print (foo == 1)
print(foo == 1)
print(list.get(0) == 2)

print(list.shift() == 2)
print(list.get(0) == 1)

print(list.pop() == 1)
list.get(0)

//: [Next](@next)
