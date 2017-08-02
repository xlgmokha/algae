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
            "left": nil,
            "right": nil
        },
        "right": {
            "value": 4,
            "left": nil,
            "right": nil
        }
    },
    "right": {
        "value": 2,
        "left": {
            "value": 4,
            "left": nil,
            "right": nil
        },
        "right": {
            "value": 3,
            "left": nil,
            "right": nil
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
        "left": nil,
        "right": {
            "value": 3,
            "left": nil,
            "right": nil
        }
    },
    "right": {
        "value": 2,
        "left": nil,
        "right": {
            "value": 3,
            "left": nil,
            "right": nil
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

describe "#symmetric?" do
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

    1
     \
      1
DOC

  def symmetric_array?(items)
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

<<-DOC
    1
   / \
  2   3
 /   /
3    2
DOC
  def symmetric?(tree)
    level, visited, queue, values_in_level = 0, 0, [tree], []

    until queue.empty?
      node = queue.shift
      values_in_level.push(node&.value)
      visited += 1
      max_per_level = (2**level)

      if visited == max_per_level
        return false unless symmetric_array?(values_in_level)

        level += 1
        visited, values_in_level = 0, []
      end

      unless leaf?(node)
        queue.push(node.left)
        queue.push(node.right)
      end
    end

    true
  end

  [
    { t: { value: 1, left: { value: 2, left: { value: 3, left: nil, right: nil }, right: { value: 4, left: nil, right: nil } }, right: { value: 2, left: { value: 4, left: nil, right: nil }, right: { value: 3, left: nil, right: nil } } }, x: true },
    { t: { value: 1, left: { value: 2, left: nil, right: { value: 3, left: nil, right: nil } }, right: { value: 2, left: nil, right: { value: 3, left: nil, right: nil } } }, x: false },
    { t: nil, x: true },
    { t: { value: 1, left: nil, right: nil }, x: true },
    { t: { value: 100, left: nil, right: { value: 100, left: nil, right: nil } }, x: false },
    { t: { value: 100, left: { value: 100, left: nil, right: nil }, right: nil }, x: false },
    { t: { value: 99, left: { value: 100, left: nil, right: nil }, right: { value: 99, left: nil, right: nil } }, x: false },
    { t: { value: 1, left: { value: 2, left: { value: 3, left: nil, right: nil }, right: nil }, right: { value: 3, left: { value: 2, left: nil, right: nil }, right: nil } }, x: false },
    { t: { "value": -191, "left": { "value": 374, "left": { "value": -361, "left": { "value": -771, "left": nil, "right": { "value": -379, "left": { "value": -154, "left": nil, "right": nil }, "right": { "value": -699, "left": nil, "right": nil } } }, "right": { "value": 159, "left": { "value": -900, "left": { "value": 305, "left": nil, "right": nil }, "right": { "value": -486, "left": nil, "right": nil } }, "right": { "value": 200, "left": { "value": -699, "left": nil, "right": nil }, "right": { "value": 470, "left": nil, "right": nil } } } }, "right": nil }, "right": { "value": 374, "left": nil, "right": { "value": -361, "left": { "value": 159, "left": { "value": 200, "left": { "value": 470, "left": nil, "right": nil }, "right": { "value": -699, "left": nil, "right": nil } }, "right": { "value": -900, "left": { "value": -486, "left": nil, "right": nil }, "right": { "value": 305, "left": nil, "right": nil } } }, "right": { "value": -771, "left": { "value": -379, "left": { "value": -699, "left": nil, "right": nil }, "right": { "value": -154, "left": nil, "right": nil } }, "right": nil } } } }, x: true },
    { t: { "value": -883, "left": { "value": -382, "left": { "value": 229, "left": { "value": -835, "left": { "value": -702, "left": { "value": 800, "left": null, "right": null }, "right": { "value": 1000, "left": null, "right": null } }, "right": { "value": 609, "left": { "value": -261, "left": null, "right": null }, "right": { "value": -967, "left": null, "right": null } } }, "right": { "value": -793, "left": { "value": 889, "left": { "value": -367, "left": null, "right": null }, "right": { "value": 748, "left": null, "right": null } }, "right": null } }, "right": { "value": 493, "left": { "value": 424, "left": null, "right": null }, "right": { "value": 93, "left": { "value": -724, "left": { "value": -870, "left": null, "right": null }, "right": { "value": -12, "left": null, "right": null } }, "right": { "value": 212, "left": { "value": -482, "left": null, "right": null }, "right": null } } } }, "right": { "value": -382, "left": { "value": 493, "left": { "value": 93, "left": { "value": 212, "left": null, "right": { "value": -482, "left": null, "right": null } }, "right": { "value": -724, "left": { "value": -12, "left": null, "right": null }, "right": { "value": -870, "left": null, "right": null } } }, "right": { "value": 424, "left": null, "right": null } }, "right": { "value": 229, "left": { "value": -793, "left": null, "right": { "value": 889, "left": { "value": 748, "left": null, "right": null }, "right": { "value": -367, "left": null, "right": null } } }, "right": { "value": -835, "left": { "value": 609, "left": { "value": -966, "left": null, "right": null }, "right": { "value": -261, "left": null, "right": null } }, "right": { "value": -702, "left": { "value": 1000, "left": null, "right": null }, "right": { "value": 800, "left": null, "right": null } } } } } }, x: false },
  ].each do |x|
    it do
      expect(symmetric?(Tree.build_from(x[:t]))).to eql(x[:x])
    end
  end
end
