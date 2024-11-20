---
layout: post
title: "Ruby's Each Loop Eventually Ends in Heartbreak"
---

## The Gold Standard

When I began learning Ruby, one of the things I noticed that it was missing a very familiar tool that I had taken for granted in PHP and C++.

{% highlight c++ %}
for (int i = 0, i < num, i++) {
  // look upon the glory that is the for loop
}
{% endhighlight %}

That small loop allows for a ton of custom iteration and is found in many programming languages. Ruby's replacement of the `for` loop was taught to me as the `each` loop, which abstracts out for loop's parameters by assuming a programmer will always want to iterate over the elements of an entire set. It adds additional flexibility by using a placeholder for each element to be referenced within the iterative loop.

{% highlight ruby %}
[1,2,3].each do |elem|
  // elem is then referenced as an object within the block
end
{% endhighlight %}

Many months had passed since that day. Projects were built and frameworks learned, and I slowly forgot about that old loop. Only until today did I realize that Ruby's `each` loop is not a replacement and treating it as such can lead down the wrong path.

## Enter Binary Trees

When traversing binary trees one typically uses a data structure known as a *queue* to make sense of the relationships. The queue is just like a line at Jimmy John's: The first person in line is the first person served, and then they exit. Every customer gets processed piece-wise until the lunch rush ends.

In terms of a [binary tree](https://en.wikipedia.org/wiki/Binary_tree), the queue is used in the following manner:
1. Start with the root of the tree in the queue
2. Add root's children to the queue (if exist)
3. Remove root from the queue
4. Begin iterating next queue (now consisting of root's children)

Queues are used alongside the [Breadth-first search (BFS)](https://en.wikipedia.org/wiki/Breadth-first_search) algorithm to search through trees. In the midst of building my own BFS algorithm was when I realized that using `#each` in Ruby for all iterative problems isn't appropriate.

## Problem & Solution

The problem I was trying to solve was a straightforward one: [return the average value of the nodes on each level](https://leetcode.com/problems/average-of-levels-in-binary-tree/). I studied this problem for many hours, watched videos on BFS and examined other user's solutions. Once I had wrapped my head around how the algorithm worked I then set out to build my own, but reaching for an each loop to solve this led to confusing results that I couldn't make out for a long, frustrating time. Note in my solution below how the `times` loop was used instead of `each`.

```ruby
# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val = 0, left = nil, right = nil)
#         @val = val
#         @left = left
#         @right = right
#     end
# end
# @param {TreeNode} root
# @return {Float[]}

# Find the average val at each level of a binary tree
def average_of_levels(root)
  queue = [root]
  avg_per_level = []
    
  while (!queue.empty?) do
    # For a binary tree of n levels we should hit this block n times
    level_sum = 0
    elems_in_level = queue.length
      
    # An each loop isn't appropiate here because we're adding children
    # to the next queue to be processed at the end of this loop. #each will
    # keep iterating over the child elements and won't allow us to stop
    # at each level and capture information while we traverse the tree.
    elems_in_level.times do
      # Pull first element in queue
      current_node = queue.shift
      level_sum += current_node.val

      # Check for node's children, if exist, add to queue
      queue << current_node.left if current_node.left != nil
      queue << current_node.right if current_node.right != nil
    end
    avg_per_level << counter/num_of_elems.to_f
  end
  avg_per_level
end
```

Want to know how many times I have used a `times` loop to solve an actual programming problem in Ruby? Zero. The Turing School of Software and Design teach the `each` loop as if it is a perfect stand-in for a `for` loop, and while that may be true for 99% of programming problems, there would have been no way for me to solve the above problem using an `each` loop using my approach. 

## Conclusion

Currently, there are only 5 submissions out of 999+ for a Ruby-based solution to the above problem, which I find hilarious. This experience has opened my eyes into how a language can hinder you if you don't examine the assumptions that are made in the inner workings of its de facto iterative loop. The beauty of C's `for` loop is it's so low-level there are no assumptions based into it.

Unfortunately, now when I work in Ruby on actual comp-sci topics I have the mental weight of deciding between two different loops instead of having a single de facto one in my toolkit.
