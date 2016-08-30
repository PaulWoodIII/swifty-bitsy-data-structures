import Foundation
/*:
 # Swifty Bitsy Data Structures
 */

/*:
 Today we're gonna learn all about data structures.
 
 "OOooooOOOooh *soo* exciting" right?
 
 Yeah, they definitely aren't the juiciest topic out there, but they are
 important. Not just to pass your computer science class, but in order to be a
 better programmer.
 
 Knowing your data structures can help you:
 
 - Manage complexity and make your programs easier to follow.
 - Build high-performance, memory-efficient programs.
 
 I believe that the former is more important. Using the
 right data structure can drastically simplify what would otherwise be
 complicated logic.
 
 The latter is important too. If performance or memory matters then
 using the right data structure is more than often essential.
 
 In order to learn about data structures, we're going to implement a few of
 them together. Don't worry, we'll keep the code nice and short. In fact,
 there are way more comments than there is code.
 
 ## What are data structures?
 
 Essentially, they are different methods of storing and organizing data that
 serve a number of different needs.
 
 Data can always be represented in many different ways. However, depending on
 what that data is and what you need to do with it, one representation will
 be a better choice than the others.
 
 To understand why, let's first talk a bit about algorithms.
 */

/*** ===================================================================== ***\
 ** - ALGORITHMS ---------------------------------------------------------- **
 * ========================================================================= *
 *                                                                           *
 *                        ,--,--.    ,--,--.                                 *
 *   ,----------.        |   |   |  |   |   |            _____               *
 *  |`----------'|       |   |   |  |   |   |           |     |    ,------.  *
 *  |            |       |   |   |  |   |   |      ,--. | o o |   |`------'| *
 *  |            |      ,| +-|-+ |  | +-|-+ |`     |  | |_____|   |        | *
 *  |            | ,:==| | |###|======|###| | |====#==#====#=,,   |        | *
 *  |            | ||   `| +---+ |  | +---+ |'  ,,=#==#====O=``  ,|        | *
 *  |            | ||    |   |   |  |   |   |   ``=#==#====#=====||        | *
 *   `----------'  ||    |   |   |  |   |   |      |__|          `|        | *
 *    | | ``=| |===``    `--,',--`  `--,',--`      /||\            `------'  *
 **   \_/    \_/         / /   \ \  / /   \ \     //||\\           |_|  |_| **
 \*** ===================================================================== ***/

/*:
  Algorithms is a fancy name for step-by-step sets of operations to be
  performed.
 
  Data structures are implemented with algorithms, and algorithms are
  implemented with data structures. It's data structures and algorithms all
  the way down until you reach the micro-scopic people with punch cards that
  control the computer (Yeah– Intel is enslaving super tiny people. Wake up
  sheeple!)
 
  Any given task can be implemented in an infinite number of ways. So for
  common tasks there are often many different algorithms that people have come up
  with.
 
  For example, there are an absurd number of algorithms for sorting a set of
  unordered items:
 
      Insertion Sort, Selection Sort, Merge Sort, Bubble Sort, Heap Sort,
      Quick Sort, Shell Sort, Timsort, Bucket Sort, Radix Sort, ...
 
  Some of these are significantly faster than others. Some use less memory.
  Some are easy to implement. Some are based on assumptions about the dataset.
 
  Every single one of them will be better for *something*. So you'll need to
  make a decision based on what your needs are and for that you'll need a way
  of comparing them, a way to measure them.
 
  When we compare the performance of algorithms we use a rough measurement of
  their average and worst-case performance using something called "Big-O".
 */

/*** ===================================================================== ***\
 ** - BIG-O NOTATION ------------------------------------------------------ **
 * ========================================================================= *
 *           a           b                                 d                 *
 *           a         b    O(N^2)                      d                    *
 *     O(N!) a        b                O(N log N)    d                    c  *
 *           a      b                            d                 c         *
 *          a      b                          d             c        O(N)    *
 *          a    b                         d         c                       *
 *          a  b                       d      c                              *
 *         a  b                     d  c                                     *
 *         ab                   c                          O(1)              *
 *  e    e    e    e    ec   d    e    e    e    e    e     e    e    e      *
 *      ba        c      d                                                   *
 *    ba   c        d                       f    f    f    f    f    f    f  *
 ** cadf    f d    f    f    f    f    f       O(log N)                     **
 \*** ===================================================================== ***/

/*:
 Big-O Notation is a way of roughly measuring the performance of algorithms
 in order to compare one against another when discussing them.

 Big-O is a mathematical notation that we borrowed in computer science to
 classify algorithms by how they respond to the number (N) of items that you
 give them.

 There are two primary things that you measure with Big-O:

 - **Time complexity** refers to the total count of operations an algorithm
   will perform given a set of items.

 - **Space complexity** refers to the total memory an algorithm will take up
   while running given a set of items.

 We measure these independently from one another because while an algorithm
 may perform less operations than another, it may also take up way more
 memory. Depending on what your requirements are, one may be a better choice
 than the other.

 These are some common Big-O's:

     Name           Notation     How you feel when they show up at your party
     ------------------------------------------------------------------------
     Constant       O(1)         AWESOME!!
     Logarithmic    O(log N)     GREAT!
     Linear         O(N)         OKAY.
     Linearithmic   O(N log N)   UGH...
     Polynomial     O(N ^ 2)     SHITTY
     Exponential    O(2 ^ N)     HORRIBLE
     Factorial      O(N!)        WTF

 To give you an idea of how many operations we're talking about. Let's look
 at what these would equal given the (N) number of items.

                N = 5            10             20             30
     -----------------------------------------------------------------------
     O(1)           1            1              1              1
     O(log N)       1.6094...    2.3025...      2.9957...      3.4011...
     O(N)           5            10             20             30
     O(N log N)     8.0471...    23.0258...     59.9146...     102.0359...
     O(N ^ 2)       25           100            400            900
     O(2 ^ N)       32           1024           1,048,576      1,073,741,824
     O(N!)          120          3,628,800      2,432,902,0... 265,252,859,812,191,058,636,308,480,000,000

 As you can see, even for relatively small sets of data you could do a *lot*
 of extra work.

 With data structures, you can perform 4 primary types of actions:
 Accessing, Searching, Inserting, and Deleting.

 It is important to note that data structures may be good at one action but
 bad at another.

                            Accessing    Searching    Inserting    Deleting
    -------------------------------------------------------------------------
                  Array     O(1)         O(N)         O(N)         O(N)
            Linked List     O(N)         O(N)         O(1)         O(1)
     Binary Search Tree     O(log N)     O(log N)     O(log N)     O(log N)

 Or rather...

                            Accessing    Searching    Inserting    Deleting
    -------------------------------------------------------------------------
                  Array     AWESOME!!    OKAY         OKAY         OKAY
            Linked List     OKAY         OKAY         AWESOME!!    AWESOME!!
     Binary Search Tree     GREAT!       GREAT!       GREAT!       GREAT!

 Even further, some actions will have a different "average" performance and a
 "worst case scenario" performance.

 There is no perfect data structure, and you choose one over another based on
 the data that you are working with and the things you are going to do with
 it. This is why it is important to know a number of different common data
 structures so that you can choose from them.
 */

/*** ===================================================================== ***\
 ** - MEMORY -------------------------------------------------------------- **
 * ========================================================================= *
 *                             _.-..                                         *
 *                           ,'9 )\)`-.,.--.                                 *
 *                           `-.|           `.                               *
 *                              \,      ,    \)                              *
 *                               `.  )._\   (\                               *
 *                                |//   `-,//                                *
 *                                ]||    //"                                 *
 **                        hjw    ""    ""                                  **
 \*** ===================================================================== ***/

/*:
 A computer's memory is pretty boring, it's just a bunch of ordered slots
 where you can store information. You hold onto memory addresses in order to
 find information.

 Lets imagine a chunk of memory like this:

      Values: |1001|0110|1000|0100|0101|1010|0010|0001|1101|1011...
   Addresses: 0    1    2    3    4    5    6    7    8    9    ...

 If you've ever wondered why things are zero-indexed in programming languages
 before, it is because of the way that memory works. If you want to read the
 first chunk of memory you read from 0 to 1, the second you read from 1 to 2.
 So the address that you hold onto for each of those is 0 and 1 respectively.

 Your computer has much much more memory than this, and it is all just a
 continuation of the pattern above.

 Memory is a bit like the wild west, every program running on your machine is
 stored within this same *physical* data structure. Without layers of
 abstraction over it, it would be extremely difficult to use.

 But these abstractions serve two additional purposes:

   - Storing data in memory in a way that is more efficient and/or faster to
     work with.
   - Storing data in memory in a way that makes it easier to use.
 */

//: [Next](@next)
