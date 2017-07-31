<<-DOC
Given a binary tree t and an integer s,
determine whether there is a root to leaf path in t
such that the sum of vertex values equals s.

Example

For

t = {
    "value": 4,
    "left": {
        "value": 1,
        "left": {
            "value": -2,
            "left": null,
            "right": {
                "value": 3,
                "left": null,
                "right": null
            }
        },
        "right": null
    },
    "right": {
        "value": 3,
        "left": {
            "value": 1,
            "left": null,
            "right": null
        },
        "right": {
            "value": 2,
            "left": {
                "value": -2,
                "left": null,
                "right": null
            },
            "right": {
                "value": -3,
                "left": null,
                "right": null
            }
        }
    }
}
and
s = 7,
the output should be hasPathWithGivenSum(t, s) = true.

This is what this tree looks like:

      4
     / \
    1   3
   /   / \
  -2  1   2
    \    / \
     3  -2 -3
Path 4 -> 3 -> 2 -> -2 gives us 7, the required sum.

For

t = {
    "value": 4,
    "left": {
        "value": 1,
        "left": {
            "value": -2,
            "left": null,
            "right": {
                "value": 3,
                "left": null,
                "right": null
            }
        },
        "right": null
    },
    "right": {
        "value": 3,
        "left": {
            "value": 1,
            "left": null,
            "right": null
        },
        "right": {
            "value": 2,
            "left": {
                "value": -4,
                "left": null,
                "right": null
            },
            "right": {
                "value": -3,
                "left": null,
                "right": null
            }
        }
    }
}
and
s = 7,
the output should be hasPathWithGivenSum(t, s) = false.

This is what this tree looks like:

      4
     / \
    1   3
   /   / \
  -2  1   2
    \    / \
     3  -4 -3
There is no path from root to leaf with the given sum 7.

Input/Output

[time limit] 4000ms (rb)
[input] tree.integer t

A binary tree of integers.

Guaranteed constraints:
0 ≤ tree size ≤ 5 · 104,
-1000 ≤ node value ≤ 1000.

[input] integer s

An integer.

Guaranteed constraints:
-4000 ≤ s ≤ 4000.

[output] boolean

Return true if there is a path from root to leaf in t such that the sum of node values in it is equal to s,
otherwise return false.
DOC

describe "#path_with_given_sum?" do
  def leaf?(node)
    node.left.nil? && node.right.nil?
  end

  def path_with_given_sum?(tree, target_sum)
    stack = []
    stack.push(tree) if tree
    sum = 0
    until stack.empty?
      node = stack.pop
      sum += node.value
      return true if leaf?(node) && sum == target_sum

      stack.push(node.left) if node.left
      stack.push(node.right) if node.right
    end
    sum == target_sum
  end

  def path_with_given_sum?(tree, target)
    return target.zero? if tree.nil?
    new_target = target - tree.value
    return new_target.zero? if leaf?(tree)
    return true if tree.left && path_with_given_sum?(tree.left, new_target)
    return true if tree.right && path_with_given_sum?(tree.right, new_target)
    false
  end

  def path_with_given_sum?(tree, target)
    return target.zero? if tree.nil?
    new_target = target - tree.value
    path_with_given_sum?(tree.left, new_target) || path_with_given_sum?(tree.right, new_target)
  end

  [
    { t: { "value": 4, "left": { "value": 1, "left": { "value": -2, "left": nil, "right": { "value": 3, "left": nil, "right": nil } }, "right": nil }, "right": { "value": 3, "left": { "value": 1, "left": nil, "right": nil }, "right": { "value": 2, "left": { "value": -2, "left": nil, "right": nil }, "right": { "value": -3, "left": nil, "right": nil } } } }, s: 7, x: true },
    { t: { "value": 4, "left": { "value": 1, "left": { "value": -2, "left": nil, "right": { "value": 3, "left": nil, "right": nil } }, "right": nil }, "right": { "value": 3, "left": { "value": 1, "left": nil, "right": nil }, "right": { "value": 2, "left": { "value": -4, "left": nil, "right": nil }, "right": { "value": -3, "left": nil, "right": nil } } } }, s: 7, x: false },
    { t: { "value": 4, "left": { "value": 1, "left": { "value": -2, "left": nil, "right": { "value": 3, "left": nil, "right": nil } }, "right": nil }, "right": { "value": 3, "left": { "value": 1, "left": { value: -1, left: nil, right: nil}, "right": nil }, "right": { "value": 2, "left": { "value": -4, "left": nil, "right": nil }, "right": { "value": -3, "left": nil, "right": nil } } } }, s: 7, x: true },
    { t: nil, s: 0, x: true },
    { t: nil, s: 1, x: false },
    { t: { "value": 5, "left": nil, "right": nil }, s: 5, x: true },
    { t: { "value": 5, "left": nil, "right": nil }, s: -5, x: false },
    { t: { "value": 5, "left": nil, "right": nil }, s: 0, x: false },
    { t: { "value": 8, "left": nil, "right": { "value": 3, "left": nil, "right": nil } }, s: 8, x: false },
  ].each do |x|
    it do
      expect(path_with_given_sum?(Tree.build_from(x[:t]), x[:s])).to eql(x[:x])
    end
  end

  class Tree
    attr_accessor :value, :left, :right

    def initialize(value, left: nil, right: nil)
      @value = value
      @left = left
      @right = right
    end

    def to_h
      { value: value, left: left&.to_h, right: right&.to_h }
    end

    def self.build_from(hash)
      return nil if hash.nil?
      Tree.new(hash[:value], left: build_from(hash[:left]), right: build_from(hash[:right]))
    end
  end
end
