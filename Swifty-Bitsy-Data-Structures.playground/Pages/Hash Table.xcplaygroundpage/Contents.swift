//: [Previous](@previous)

import Foundation

/*:
 Lists are great for fast access and dealing with items at the end. However, as we've seen it isn't great at dealing with items not at the end of the list and we have to manually hold onto memory addresses.
 
 So let's take a look at a different data structure and how it deals with adding, accessing, and removing values without needing to know memory addresses.
 
 A hash table is a data structure that's *unordered*. Instead we have "keys" and "values" where we computed an address in memory using the key.
 
 The basic idea is that we have keys that are "hashable" (which we'll get to in a second) and can by used to add, access, and remove from memory very efficiently.
 
     var hashTable = HashTable<String,String>()
     
     hashTable.set('myKey', 'myValue')
     hashTable.get('myKey') // >> 'myValue'
 */

struct HashTableNode<T:Comparable> {
    var element : T?
    var isEmpty : Bool {
        get {
            if element != nil {
                return false
            }
            return true
        }
    }
}

class HashTable<T : Hashable, V: Comparable> {
    
    /**
     * Again we're going to use a plain Array of Nodes to represent our memory.
     */
    var memory :  Array<HashTableNode<V>> = {
        let node = HashTableNode<V>()
        let array = Array<HashTableNode<V>>(repeating: node, count: 100)
        return array
    }()
    
/*:
  In order to store key-value pairs in memory from our hash table we need a way to take the key and turn it into an address. We do this through an operation known as "hashing".
 
  Basically it takes a key and serializes it into a unique number for that key.
 
     hashKey("abc") =>  96354
     hashKey("xyz") => 119193
 
  You have to be careful though, if you had a really big key you don't want to match it to a memory address that does not exist.
 
  So the hashing algorithm needs to limit the size, which means that there are a limited number of addresses for an unlimited number of values.
 
  The result is that you can end up with collisions. Places where two keys get turned into the same address.
 
  Any real world hash table implementation would have to deal with this, however we are just going to glaze over it and pretend that doesn't happen.

  Let's setup our "hashKey" function.
 
  Don't worry about understanding the logic of this function, just know that it accepts a string and outputs a (mostly) unique address that we will use in all of our other functions.
 */
    
    func hashKey(_ key : T) -> Int {
        return key.hashValue % memory.count
    }
    
/*:
 Next, lets define our "get" function so we have a way of accessing values
 by their key.
 
 HashTable access is constant O(1) - "AWESOME!!"
 */
    
    func get(key : T) -> V? {
        // We start by turning our key into an address.
        let address = hashKey(key);
        // Then we simply return whatever is at that address.
        return memory[address].element
    }
    
/*:
 We also need a way of adding data before we access it, so we will create
 a "set" function that inserts values.
 
 HashTable setting is constant O(1) - "AWESOME!!"
 */
    
    func set(key : T, value : V) {
        // Again we start by turning the key into an address.
        let address = hashKey(key);
        // Then just set the value at that address.
        memory[address].element = value;
    }
    
/*:
 Finally we just need a way to remove items from our hash table.
 
 HashTable deletion is constant O(1) - "AWESOME!!"
 */
    func remove(key : T) {
        // As always, we hash the key to get an address.
        let address = hashKey(key);
        // Then, if it exists, we `delete` it.
        if !memory[address].isEmpty {
            memory[address].element = nil
        }
    }
}

var hashTable = HashTable<String,String>()

hashTable.set(key: "foo", value: "bar");
print(hashTable.get(key: "foo") == "bar");

hashTable.remove(key: "foo");
print(hashTable.get(key: "foo"));

//: [Next](@next)
