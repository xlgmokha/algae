<<-DOC
Note: Your solution should have only one BST traversal and O(1) extra space complexity,
since this is what you will be asked to accomplish in an interview.

A tree is considered a binary search tree (BST) if for each of its nodes the following is true:

The left subtree of a node contains only nodes with keys less than the node's key.
The right subtree of a node contains only nodes with keys greater than the node's key.
Both the left and the right subtrees must also be binary search trees.
Given a binary search tree t, find the kth largest element in it.

Note that kth largest element means kth element in increasing order. See examples for better understanding.

Example

For

t = {
    "value": 3,
    "left": {
        "value": 1,
        "left": null,
        "right": null
    },
    "right": {
        "value": 5,
        "left": {
            "value": 4,
            "left": null,
            "right": null
        },
        "right": {
            "value": 6,
            "left": null,
            "right": null
        }
    }
}
and k = 2, the output should be
kthLargestInBST(t, k) = 3.

Here is what t looks like:

   3
 /   \
1     5
     / \
    4   6
The values of t are [1, 3, 4, 5, 6], and the 2nd element when the values are in sorted order is 3.

For

t = {
    "value": 1,
    "left": {
        "value": -1,
        "left": {
            "value": -2,
            "left": null,
            "right": null
        },
        "right": {
            "value": 0,
            "left": null,
            "right": null
        }
    },
    "right": null
}

and k = 1, the output should be
kthLargestInBST(t, k) = -2.

Here is what t looks like:

     1
    /
  -1
  / \
-2   0
The values of t are [-2, -1, 0, 1], and the 1st largest is -2.

Input/Output

[time limit] 4000ms (rb)
[input] tree.integer t

A tree of integers. It is guaranteed that t is a BST.

Guaranteed constraints:
1 ≤ tree size ≤ 104,
-105 ≤ node value ≤ 105.

[input] integer k

An integer.

Guaranteed constraints:
1 ≤ k ≤ tree size.

[output] integer

The kth largest value in t
DOC

describe "#kth_largest_in_bst" do
  def kth_largest_in_bst(tree, k)
    puts tree.to_a.inspect
    stack = [tree]
    all = [ ]
    until stack.empty?
      node = stack.pop
      all.push(node.value)
      stack.push(node.left) if node.left
      stack.push(node.right) if node.right
    end
    puts all.inspect
    all[k + 1]
  end

  def to_array(tree)
    return [] if tree.nil?
    to_array(tree.left) + [tree.value] + to_array(tree.right)
  end

  def kth_largest_in_bst(tree, k)
    to_array(tree)[k - 1]
  end

  class Traversal
    attr_reader :k

    def initialize(k)
      @counter = 0
      @k = k
    end

    def traverse(tree)
      return if tree.nil?

      if @counter < k && result = traverse(tree.left)
        return result
      end

      @counter += 1
      return tree.value if @counter == k

      traverse(tree.right) if @counter < k
    end
  end

  def kth_largest_in_bst(tree, k)
    Traversal.new(k).traverse(tree)
  end

  [
    { t: { "value": 3, "left": { "value": 1, "left": nil, "right": nil }, "right": { "value": 5, "left": { "value": 4, "left": nil, "right": nil }, "right": { "value": 6, "left": nil, "right": nil } } }, k: 2, x: 3 },
    { t: { "value": 1, "left": { "value": -1, "left": { "value": -2, "left": nil, "right": nil }, "right": { "value": 0, "left": nil, "right": nil } }, "right": nil }, k: 1, x: -2 },
    { t: { "value": 100, "left": nil, "right": nil }, k: 1, x: 100 },
    { t: { "value": 1, "left": { "value": 0, "left": nil, "right": nil }, "right": { "value": 2, "left": nil, "right": nil } }, k: 3, x: 2 },
    { t: { "value": 1, "left": { "value": 0, "left": nil, "right": nil }, "right": { "value": 2, "left": nil, "right": nil } }, k: 2, x: 1 },
    { t: { "value": -2, "left": nil, "right": { "value": 3, "left": { "value": 2, "left": nil, "right": nil }, "right": nil } }, k: 1, x: -2 }
  ].each do |x|
    it do
      expect(kth_largest_in_bst(Tree.build_from(x[:t]), x[:k])).to eql(x[:x])
    end
  end

end
