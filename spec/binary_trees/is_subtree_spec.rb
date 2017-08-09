<<-DOC
Given two binary trees t1 and t2, determine whether the second one is a subtree of the first one.
A subtree for vertex v in binary tree t is a tree consisting of v and all its descendants in t.
Your task is to check whether there is a vertex v in tree t1 such that a subtree for vertex v in t1 equals t2.

Example

For

t1 = {
    value: 5,
    left: {
        value: 10,
        left: {
            value: 4,
            left: {
                value: 1,
                left: null,
                right: null
            },
            right: {
                value: 2,
                left: null,
                right: null
            }
        },
        right: {
            value: 6,
            left: null,
            right: {
                value: -1,
                left: null,
                right: null
            }
        }
    },
    right: {
        value: 7,
        left: null,
        right: null
    }
}
and

t2 = {
    value: 10,
    left: {
        value: 4,
        left: {
            value: 1,
            left: null,
            right: null
        },
        right: {
            value: 2,
            left: null,
            right: null
        }
    },
    right: {
        value: 6,
        left: null,
        right: {
            value: -1,
            left: null,
            right: null
        }
    }
}
the output should be isSubtree(t1, t2) = true.

This is what these trees look like:

      t1:             t2:
       5              10
      / \            /  \
    10   7          4    6
   /  \            / \    \
  4    6          1   2   -1
 / \    \
1   2   -1
As you can see, t2 is a subtree of t1 (the vertex in t1 with value 10).

For

t1 = {
    value: 5,
    left: {
        value: 10,
        left: {
            value: 4,
            left: {
                value: 1,
                left: null,
                right: null
            },
            right: {
                value: 2,
                left: null,
                right: null
            }
        },
        right: {
            value: 6,
            left: {
                value: -1,
                left: null,
                right: null
            },
            right: null
        }
    },
    right: {
        value: 7,
        left: null,
        right: null
    }
}
and

t2 = {
    value: 10,
    left: {
        value: 4,
        left: {
            value: 1,
            left: null,
            right: null
        },
        right: {
            value: 2,
            left: null,
            right: null
        }
    },
    right: {
        value: 6,
        left: null,
        right: {
            value: -1,
            left: null,
            right: null
        }
    }
}
the output should be isSubtree(t1, t2) = false.

This is what these trees look like:

        t1:            t2:
         5             10
       /   \          /  \
     10     7        4    6
   /    \           / \    \
  4     6          1   2   -1
 / \   / 
1   2 -1
As you can see, there is no vertex v such that the subtree of t1 for vertex v equals t2.

For

t1 = {
    value: 1,
    left: {
        value: 2,
        left: null,
        right: null
    },
    right: {
        value: 2,
        left: null,
        right: null
    }
}
and

t2 = {
    value: 2,
    left: {
        value: 1,
        left: null,
        right: null
    },
    right: null
}
the output should be isSubtree(t1, t2) = false.

Input/Output

[time limit] 4000ms (rb)
[input] tree.integer t1

A binary tree of integers.

Guaranteed constraints:
0 ≤ tree size ≤ 6 · 104,
-1000 ≤ node value ≤ 1000.

[input] tree.integer t2

Another binary tree of integers.

Guaranteed constraints:
0 ≤ tree size ≤ 6 · 104,
-1000 ≤ node value ≤ 1000.

[output] boolean

Return true if t2 is a subtree of t1, otherwise return false.
DOC
describe "#subtree?" do
  # (1(2(),3())
  def to_sexpression(tree)
    return "()" if tree.nil?
    "(#{tree.value}#{to_sexpression(tree.left)},#{to_sexpression(tree.right)})"
  end

  def subtree?(t1, t2)
    return true if (t1.nil? && t2.nil?) || (t1 && t2.nil?)
    to_sexpression(t1).include?(to_sexpression(t2))
  end

  null = nil
  [
    { t1: { value: 5, left: { value: 10, left: { value: 4, left: { value: 1, left: null, right: null }, right: { value: 2, left: null, right: null } }, right: { value: 6, left: null, right: { value: -1, left: null, right: null } } }, right: { value: 7, left: null, right: null } }, t2: { value: 10, left: { value: 4, left: { value: 1, left: null, right: null }, right: { value: 2, left: null, right: null } }, right: { value: 6, left: null, right: { value: -1, left: null, right: null } } }, x: true },
    { t1: { value: 5, left: { value: 10, left: { value: 4, left: { value: 1, left: null, right: null }, right: { value: 2, left: null, right: null } }, right: { value: 6, left: { value: -1, left: null, right: null }, right: null } }, right: { value: 7, left: null, right: null } }, t2: { value: 10, left: { value: 4, left: { value: 1, left: null, right: null }, right: { value: 2, left: null, right: null } }, right: { value: 6, left: null, right: { value: -1, left: null, right: null } } }, x: false },
    { t1: { value: 1, left: { value: 2, left: null, right: null }, right: { value: 2, left: null, right: null } }, t2: { value: 2, left: { value: 1, left: null, right: null }, right: null }, x: false },
    { t1: { value: 1, left: { value: 2, left: null, right: null }, right: { value: 2, left: null, right: null } }, t2: null, x: true },
    { t1: null, t2: null, x: true },
    { t1: null, t2: { value: 2, left: null, right: null }, x: false },
    { t1: { value: 1, left: { value: 2, left: null, right: null }, right: { value: 2, left: null, right: null } }, t2: { value: 2, left: null, right: null }, x: true },
    { t1: { value: 3, left: { value: 1 }, right: {} }, t2: null, x: true },
    { t1: { value: 2, right: { value: 3 } }, t2: { value: 2, left: { value: 1 }, right: { value: 3 } }, x: false },
  ].each do |x|
    <<-DOC

    2
     \
      3

       2
     /  \
    1    3

    DOC
    it do
      expect(
        subtree?(Tree.build_from(x[:t1]), Tree.build_from(x[:t2]))
      ).to eql(x[:x])
    end
  end
end
