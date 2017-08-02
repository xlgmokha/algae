<<-DOC
Given a binary tree t, determine whether it is symmetric around its center,
i.e. each side mirrors the other.

Example

For

t = {
    "value": 1,
    "left": {
        "value": 2,
        "left": {
            "value": 3,
            "left": null,
            "right": null
        },
        "right": {
            "value": 4,
            "left": null,
            "right": null
        }
    },
    "right": {
        "value": 2,
        "left": {
            "value": 4,
            "left": null,
            "right": null
        },
        "right": {
            "value": 3,
            "left": null,
            "right": null
        }
    }
}
the output should be isTreeSymmetric(t) = true.

Here's what the tree in this example looks like:

    1
   / \
  2   2
 / \ / \
3  4 4  3
As you can see, it is symmetric.

For

t = {
    "value": 1,
    "left": {
        "value": 2,
        "left": null,
        "right": {
            "value": 3,
            "left": null,
            "right": null
        }
    },
    "right": {
        "value": 2,
        "left": null,
        "right": {
            "value": 3,
            "left": null,
            "right": null
        }
    }
}
the output should be isTreeSymmetric(t) = false.

Here's what the tree in this example looks like:

    1
   / \
  2   2
   \   \
   3    3
As you can see, it is not symmetric.

Input/Output

[time limit] 4000ms (rb)
[input] tree.integer t

A binary tree of integers.

Guaranteed constraints:
0 ≤ tree size < 5 · 104,
-1000 ≤ node value ≤ 1000.

[output] boolean

Return true if t is symmetric and false otherwise.
DOC
require 'ostruct'

describe "#symetric?" do
<<-DOC
    1
   / \
  2   2
 / \ / \
3  4 4  3

    1
   /
  2
 / \
3  4
DOC

  def symetric_array?(items)
    head, tail = 0, items.size - 1

    until head >= tail
      return false if items[head] != items[tail]

      head += 1
      tail -= 1
    end
    true
  end

  def leaf?(node)
    return true if node.nil?
    node.left.nil? && node.right.nil?
  end

  def symetric?(tree)
    queue = [tree]
    level = 0
    visited = 0
    nodes_in_level = []

    until queue.empty?
      node = queue.shift
      nodes_in_level.push(node&.value)
      visited += 1

      if visited >= (2**level)
        return false unless symetric_array?(nodes_in_level)

        level += 1
        visited = 0
        nodes_in_level = []
      end

      unless leaf?(node)
        queue.push(node.left)
        queue.push(node.right)
      end
    end

    true
  end

  [
    { t: { "value": 1, "left": { "value": 2, "left": { "value": 3, "left": nil, "right": nil }, "right": { "value": 4, "left": nil, "right": nil } }, "right": { "value": 2, "left": { "value": 4, "left": nil, "right": nil }, "right": { "value": 3, "left": nil, "right": nil } } }, x: true },
    { t: { "value": 1, "left": { "value": 2, "left": nil, "right": { "value": 3, "left": nil, "right": nil } }, "right": { "value": 2, "left": nil, "right": { "value": 3, "left": nil, "right": nil } } }, x: false },
  ].each do |x|
    it do
      expect(symetric?(Tree.build_from(x[:t]))).to eql(x[:x])
    end
  end
end
