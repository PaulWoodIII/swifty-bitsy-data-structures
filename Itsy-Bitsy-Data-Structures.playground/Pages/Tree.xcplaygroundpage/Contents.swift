//: [Previous](@previous)

import Foundation

/**
 * The remaining two data structures we are going to cover are both in the
 * "tree" family.
 *
 * Much like real life, there are many different types of tree data structures.
 *
 *     Binary Trees:
 *       AA Tree, AVL Tree, Binary Search Tree, Binary Tree, Cartesian Tree,
 *       left child/right sibling tree, order statistic tree, Pagoda, ...
 *
 *     B Trees:
 *       B Tree, B+ Tree, B* Tree, B Sharp Tree, Dancing Tree, 2-3 Tree, ...
 *
 *     Heaps:
 *       Heap, Binary Heap, Weak Heap, Binomial Heap, Fibonacci Heap, Leonardo
 *       Heap, 2-3 Heap, Soft Heap, Pairing Heap, Leftist Heap, Treap, ...
 *
 *     Trees:
 *       Trie, Radix Tree, Suffix Tree, Suffix Array, FM-index, B-trie, ...
 *
 *     Multi-way Trees:
 *       Ternary Tree, K-ary tree, And-or tree, (a,b)-tree, Link/Cut Tree, ...
 *
 *     Space Partitioning Trees:
 *       Segment Tree, Interval Tree, Range Tree, Bin, Kd Tree, Quadtree,
 *       Octree, Z-Order, UB-Tree, R-Tree, X-Tree, Metric Tree, Cover Tree, ...
 *
 *     Application-Specific Trees:
 *       Abstract Syntax Tree, Parse Tree, Decision Tree, Minimax Tree, ...
 *
 * Little did you know you'd be studying dendrology today... and thats not even
 * all of them. But don't let any of this scare you, most of those don't matter
 * at all. There were just a lot of Computer Science PhDs who had something to
 * prove.
 *
 * Trees are much like graphs or linked lists except they are "unidirectional".
 * All this means is that they can't have loops of references.
 *
 *        Tree:                Not a Tree:
 *
 *          A                        A
 *        ↙   ↘                    ↗   ↘
 *      B       C                B ←–––– C
 *
 * If you can draw a loop between connected nodes in a tree... well, you don't
 * have a tree.
 *
 * Trees have many different uses, they can be used to optimize searching or
 * sorting. They can organize programs better. They can give you a
 * representation that is easier to work with.
 */

/*** ===================================================================== ***\
 ** - TREES --------------------------------------------------------------- **
 * ========================================================================= *
 *            ccee88oo             \ | /                                     *
 *          C8O8O8Q8PoOb o8oo    '-.;;;.-,   ooooO8O8QOb o8bDbo              *
 *        dOB69QO8PdUOpugoO9bD  -==;;;;;==-aadOB69QO8PdUOpugoO9bD            *
 *       CgggbU8OU qOp qOdoUOdcb .-';;;'-.  CgggOU ddqOp qOdoUOdcb           *
 *           6OuU  /p u gcoUodpP   / | \ jgs  ooSec cdac pdadfoof            *
 *             \\\//  /douUP         '         \\\d\\\dp/pddoo               *
 *               \\\////                         \\ \\////                   *
 *                |||/\                           \\///                      *
 *                |||\/                           ||||                       *
 *                |||||                          /|||                        *
 ** .............//||||\.......................//|||\\..................... **
 \*** ===================================================================== ***/

/**
 * We'll start off with an extremely simple tree structure. It doesn't have any
 * special rules to it and looks someting like this:
 *
 *     Tree {
 *       root: {
 *         value: 1,
 *         children: [{
 *           value: 2,
 *           children: [...]
 *         }, {
 *           value: 3,
 *           children: [...]
 *         }]
 *       }
 *     }
 */

class TreeNode<T where T:Equatable> {
    var value : T
    var children : [TreeNode<T>] = []
    
    init(value v: T){
        value = v
    }
}

class Tree<T where T:Equatable> {
    
    /**
     * The tree has to start with a single parent, the "root" of the tree.
     */
    var root : TreeNode<T>?
    
    init(root r : TreeNode<T>){
        root = r
    }
    
    /**
     * We need a way to traverse our tree and call a function on each node in the
     * tree.
     */
    
    func traverse(_ callback: (TreeNode<T>)->() ) {
        guard let root = root else {
            // If no root just return
            return
        }
        
        // We'll define a walk function that we can call recursively on every node
        // in the tree.
        func walk(_ node : TreeNode<T>) {
            // First call the callback on the node.
            callback(node);
            // Then recursively call the walk function on all of its children.
            node.children.forEach(walk);
        }
        
        // Now kick the traversal process off.
        walk(root);
    }
    
    /**
     * Next we need a way to add nodes to our tree.
     */
    
    func add(value : T, parentValue : T) {
        let newNode = TreeNode(value:value)
        
        // If there is no root, just set it to the new node.
        if (root == nil) {
            root = newNode;
            return;
        }
        
        // Otherwise traverse the entire tree and find a node with a matching value
        // and add the new node to its children.
        traverse { (node) in
            if (node.value == parentValue) {
                node.children.append(newNode);
            }
        }
    }
}

/**
 * This is one of the most basic trees you could have and is probably only
 * useful if the data you are representing actually resembles a tree.
 *
 * But with some extra rules a tree can serve a lot of different purposes.
 */

//: [Next](@next)
