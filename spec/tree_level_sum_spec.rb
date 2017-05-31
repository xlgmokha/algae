description = <<-DESC
Given a binary tree and a number k, your task is to find the sum of tree nodes at level k. 
The binary tree is represented by a string tree with the format: (<node-value>(<left subtree>)(<right subtree>)).

Example

For tree = "(0(5(6()())(14()(9()())))(7(1()())(23()())))" and k = 2, the output should be

treeLevelSum(tree, k) = 44.

Explanation: The nodes at level 2 are 6, 14, 1, and 23, so the answer is 6 + 14 + 1 + 23 = 44.

Input/Output

[time limit] 4000ms (rb)
[input] string tree

A valid string representing a tree.

Guaranteed constraints:

2 ≤ tree.length ≤ 105.

All the values in a given tree are guaranteed to be integers.

[input] integer k

Guaranteed constraints:

0 ≤ k ≤ 105.

[output] integer

The total sum of all the values at level k in a tree.

https://en.wikipedia.org/wiki/S-expression
DESC

describe "tree_level_sum" do
  # parse s-expression
  def parse(tokens, values, offset = 0)
    struct = []
    while offset < tokens.length
      if "(" == tokens[offset]
        offset, items = parse(tokens, values, offset + 1)
        struct << items
      elsif ")" == tokens[offset]
        break
      else
        struct << values.shift
      end
      offset += 1
    end

    return [offset, struct]
  end

  def build_tree(string)
    tokens = string.gsub("(", " ( ").gsub(")", " ) ").split(" ")
    values = string.scan(/\d+/).map(&:to_i)
    _, tree = parse(tokens, values, 0)
    tree[0]
  end

  def tree_level_sum(tree, target)
    tree = build_tree(tree)
    puts tree.inspect
    queue = [node: tree, level: 0]

    until queue.empty?
      top = queue.shift

      if top[:level] == target
        puts top[:node].map { |x| x }.inspect
        break
      end

      left = top[:node][1]
      right = top[:node][2]
      if left.size > 0
        queue.push(node: left, level: top[:level] + 1)
      end
      if right.size > 0
        queue.push(node: right, level: top[:level] + 1)
      end
    end
    # 6 + 14 + 1  + 23
    # tree[1][1][0] + tree[1][2][0] + tree[2][1][0] + tree[2][2][0]
    0
  end

  def tree_level_sum(tree, target)
    # ( + level
    # ) - level
    # if level == target
    #   add number to sum
    level = -1
    sum = 0
    tokens = tree.gsub("(", " ( ").gsub(")", " ) ").split(" ")
    tokens.each do |token|
      if token == "("
        level += 1
      elsif token == ")"
        level -= 1
      else
        if level == target
          sum += token.to_i
        end
      end
    end
    sum
  end

  <<-EXAMPLE
       0
      / \
     /   \
    5     7
   / \   / \
  6  14 1  23
       \
        9

  (0(5(6()())(14()(9()()))) (7(1()())(23()())))
[0,
  [ 5,
    [6, [], [] ],
    [14, [], [9, [], []]]
  ],
  [ 7,
    [1, [], []],
    [23, [], []]
  ]
]
level 2: tree[1][1][0] + tree[1][2][0] + tree[2][1][0] + tree[2][2][0] = 44
  EXAMPLE
  [
    ["(0(5(6()())(14()(9()())))(7(1()())(23()())))", 2, 44],
  ].each do |(tree, level, expected)|
    it do
      expect(tree_level_sum(tree, level)).to eql(expected)
    end
  end
end
