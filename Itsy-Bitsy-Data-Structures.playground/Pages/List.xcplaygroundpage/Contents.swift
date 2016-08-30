//: [Previous](@previous)

import Foundation

/*** ===================================================================== ***\
 ** - LISTS --------------------------------------------------------------- **
 * ========================================================================= *
 *                  *     _______________________                            *
 *                    ()=(_______________________)=()           *            *
 *       *                |                     |                            *
 *                        |   ~ ~~~~~~~~~~~~~   |       *               *    *
 *             *          |                     |                            *
 *   *                    |   ~ ~~~~~~~~~~~~~   |         *                  *
 *                        |                     |                            *
 *                        |   ~ ~~~~~~~~~~~~~   |                 *          *
 *        *               |                     |                            *
 *                   *    |_____________________|         *        *         *
 *                    ()=(_______________________)=()                        *
 **                                                                         **
 \*** ===================================================================== ***/

/*:
 To demonstrate the raw interaction between memory and a data structure we're
 going to first implement a list.
 
 A list is a representation of an ordered sequence of values where the same
 value may appear many times.
 */

class List {
    
    /*
     * We start with an empty block of memory which we are going to represent
     * with a normal JavaScript array and we'll store the length of the list.
     *
     * Note that we want to store the length separately because in real life the
     * "memory" doesn't have a length you can read from.
     */
    var memory :Array<Any> = []
    var length = 0
    
    /*
     * First we need a way to retrieve data from our list.
     *
     * With a plain list, you have very fast memory access because you keep track
     * of the address directly.
     *
     * List access is constant O(1) - "AWESOME!!"
     */
    
    func get(_ address : Int) -> Any {
        return memory[address]
    }
    
    /*
     * Because lists have an order you can insert stuff at the start, middle,
     * or end of them.
     *
     * For our implementation we're going to focus on adding and removing values
     * at the start or end of our list with these four methods:
     *
     *   - Push    - Add value to the end
     *   - Pop     - Remove value from the end
     *   - Unshift - Add value to the start
     *   - Shift   - Remove value from the start
     */
    
    /*
     * Starting with "push" we need a way to add items to the end of the list.
     *
     * It is as simple as adding a value in the address after the end of our
     * list. Because we store the length this is easy to calculate. We just add
     * the value and increment our length.
     *
     * Pushing an item to the end of a list is constant O(1) - "AWESOME!!"
     */
    func push(value : Any) {
        memory[length] = value
        length = length + 1
    }
    
    /*
     * Next we need a way to "pop" items off of the end of our list.
     *
     * Similar to push all we need to do is remove the value at the address at
     * the end of our list. Then just decrement length.
     *
     * Popping an item from the end of a list is constant O(1) - "AWESOME!!"
     */
    
    func pop() -> Any? {
        // Don't do anything if we don't have any items.
        if (length == 0) {
            return nil
        }
        
        // Get the last value, stop storing it, and return it.
        let lastAddress = length - 1;
        let value = memory[lastAddress];
        length -= 1;
        
        // Also return the value so it can be used.
        return value;
    }
    
    /*
     * "push" and "pop" both operate on the end of a list, and overall are pretty
     * simple operations because they don't need to be concerned with the rest of
     * the list.
     *
     * Let's see what happens when we operate on the begining of the list with
     * "unshift" and "shift".
     */
    
/*:
In order to add a new item at the beginning of our list, we need to make
room for our value at the start by sliding all of the values over by one.

      [a, b, c, d, e]
       0  1  2  3  4
        ⬊  ⬊  ⬊  ⬊  ⬊
          1  2  3  4  5
      [x, a, b, c, d, e]

In order to slide all of the items over we need to iterate over each one
moving the prev value over.

Because we have to iterate over every single item in the list:

Unshifting an item to the start of a list is linear O(N) - "OKAY."
*/
    
    func unshift(value : Any) {
        // Store the value we are going to add to the start.
        var previous = value;
        
        // Iterate through each item...
        for address in 0 ..< length {
            // replacing the "current" value with the "previous" value and storing the
            // "current" value for the next iteration.
            let current = memory[address];
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
    
    func shift() -> Any? {
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
        
        return value;
    }
}

//: [Next](@next)
