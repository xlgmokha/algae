<<-DOC
A tree is considered a binary search tree (BST) if for each of its nodes the following is true:

The left subtree of a node contains only nodes with keys less than the node's key.
The right subtree of a node contains only nodes with keys greater than the node's key.
Both the left and the right subtrees must also be binary search trees.
Removing a value x from a BST t is done in the following way:

If there is no x in t, nothing happens;
Otherwise, let t' be a subtree of t such that t'.value = x.
If t' has a left subtree, remove the rightmost node from it and put it at the root of t';
Otherwise, remove the root of t' and its right subtree becomes the new t's root.
For example, removing 4 from the following tree has no effect because there is no such value in the tree:

    5
   / \
  2   6
 / \   \
1   3   8
       /
      7
Removing 5 causes 3 (the rightmost node in left subtree) to move to the root:

    3
   / \
  2   6
 /     \
1       8
       /
      7
And removing 6 after that creates the following tree:

    3
   / \
  2   8
 /   /
1   7
You're given a binary search tree t and an array of numbers queries. Your task is to remove queries[0], queries[1],
etc., from t, step by step, following the algorithm above. Return the resulting BST.

Example

For

t = {
    "value": 5,
    "left": {
        "value": 2,
        "left": {
            "value": 1,
            "left": null,
            "right": null
        },
        "right": {
            "value": 3,
            "left": null,
            "right": null
        }
    },
    "right": {
        "value": 6,
        "left": null,
        "right": {
            "value": 8,
            "left": {
                "value": 7,
                "left": null,
                "right": null
            },
            "right": null
        }
    }
}
and queries = [4, 5, 6], the output should be

deleteFromBST(t, queries) = {
    "value": 3,
    "left": {
        "value": 2,
        "left": {
            "value": 1,
            "left": null,
            "right": null
        },
        "right": null
    },
    "right": {
        "value": 8,
        "left": {
            "value": 7,
            "left": null,
            "right": null
        },
        "right": null
    }
}
Input/Output

[time limit] 4000ms (rb)
[input] tree.integer t

A tree of integers.

Guaranteed constraints:
0 ≤ t size ≤ 1000,
-109 ≤ node value ≤ 109.

[input] array.integer queries

An array that contains the numbers to be deleted from t.

Guaranteed constraints:
1 ≤ queries.length ≤ 1000,
-109 ≤ queries[i] ≤ 109.

[output] tree.integer

The tree after removing all the numbers in queries, following the algorithm above.
DOC

describe "#delete_from_bst" do
  <<-DOC
  If there is no x in t, nothing happens;
  Otherwise, let t' be a subtree of t such that t'.value = x.
  If t' has a left subtree, remove the rightmost node from it and put it at the root of t';
  Otherwise, remove the root of t' and its right subtree becomes the new t's root.

  If t' has a left subtree and the left subtree has a child on the right, 
  the node you should put at the root of t' is the rightmost node (not necessarily leaf) in this subtree. 
  When you remove the rightmost node, you must also discard its children 
  (rather than keeping them as children of the rightmost node's parent).

    3
   / \
  2   5
 /
1
remove 3:

  2
 / \
1   5

remove 2:

  1
   \
    5

remove 1

  5



And removing 6 after that creates the following tree:

{ value: 3, left: { value: 2, left: { value: 1 } }, right: { value: 6, left: { value: 5 }, right: { value: 8, left: { value: 7 } } } }
    3
   / \
  2   6
 /  /  \
1  5    8
       /
      7

{ value: 3, left: { value: 2, left: { value: 1 } }, right: { value: 5, right: { value: 8, left: { value: 7 } } } }
    3
   / \
  2   5
 /     \
1       8
       /
      7


Instead of recursively removing the largest node from the right subtree using the specified algorithm,
they want you to take the largest node's left subtree and make it the child of the largest node's parent
  DOC

  def remove(tree, target)
    return nil if tree.nil?

    if target < tree.value
      tree.left = remove(tree.left, target)
    elsif tree.value < target
      tree.right = remove(tree.right, target)
    else
      if tree.left.nil?
        return tree.right
      elsif tree.right.nil?
        return tree.left
      else
        max, parent = tree.left, tree
        while max.right
          parent = max
          max = max.right
        end

        tree.value = max.value
        if parent == tree
          tree.left = tree.left.left
        else
          parent&.right = max.left
        end

        #max = tree.left
        #max = max.right while max.right
        #tree.value = max.value
        #tree.left = remove(tree.left, tree.value)

        #min = tree.right
        #min = min.left while min.left
        #tree.value = min.value
        #tree.right = remove(tree.right, tree.value)
      end
    end
    tree
  end

  def delete_from_bst(tree, queries)
    return nil if tree.nil?
    queries.each do |target|
      #puts [target].inspect
      #tree&.print
      tree = remove(tree, target)
    end
    tree
  end

  null = nil
  [
    { t: { "value": 5, "left": { "value": 2, "left": { "value": 1, "left": null, "right": null }, "right": { "value": 3, "left": null, "right": null } }, "right": { "value": 6, "left": null, "right": { "value": 8, "left": { "value": 7, "left": null, "right": null }, "right": null } } }, queries: [4, 5, 6], x: { "value": 3, "left": { "value": 2, "left": { "value": 1, "left": null, "right": null }, "right": null }, "right": { "value": 8, "left": { "value": 7, "left": null, "right": null }, "right": null } } },
    { t: null, queries: [1, 2, 3, 5], x: nil },
    { t: { "value": 3, "left": { "value": 2, "left": null, "right": null }, "right": null }, queries: [1, 2, 3, 5], x: nil },
    { t: { "value": 3, "left": { "value": 2, "left": null, "right": null }, "right": { "value": 5, "left": null, "right": null } }, queries: [1, 2, 3, 5], x: nil },
    { t: { "value": 3, "left": { "value": 2, "left": { "value": 1, "left": null, "right": null }, "right": null }, "right": { "value": 5, "left": null, "right": null } }, queries: [3, 2, 1], x: { "value": 5, "left": null, "right": null } },
    { t: { "value": 5, "left": { "value": 3, "left": { "value": 1, "left": null, "right": null }, "right": { "value": 4, "left": null, "right": null } }, "right": { "value": 7, "left": null, "right": null } }, queries: [1, 7, 4, 6], x: { "value": 5, "left": { "value": 3, "left": null, "right": null }, "right": null } },
    { t: { value: 3, left: { value: 2, left: { value: 1 } }, right: { value: 6, left: { value: 5 }, right: { value: 8, left: { value: 7 } } } }, queries: [6], x: { value: 3, left: { value: 2, left: { value: 1 } }, right: { value: 5, right: { value: 8, left: { value: 7 } } } } },
    { t: { "value": 3, "left": { "value": 2, "left": { "value": 1, "left": null, "right": null }, "right": null }, "right": { "value": 5, "left": null, "right": null } }, queries: [3], x: { "value": 2, "left": { "value": 1, "left": null, "right": null }, "right": { "value": 5, "left": null, "right": null } } },
    { t: null, queries: [100000000, -1000000000, 0, 1, -1, 2, -2], x: null },
    { t: { "value": 3, "left": { "value": 2, "left": null, "right": null }, "right": { "value": 5, "left": null, "right": null } }, queries: [2, 3, 0, 5], x: nil },
  ].each do |x|
    it do
      result = delete_from_bst(Tree.build_from(x[:t]), x[:queries])
      expected = x[:x] ? Tree.build_from(x[:x]).to_s : nil
      expect(result ? result.to_s : result).to eql(expected)
    end
  end

  it do
    require_relative 'spec_8'
    x = SPEC8
    result = delete_from_bst(Tree.build_from(x[:t]), x[:queries])
    expected = x[:x] ? Tree.build_from(x[:x]).to_s : nil
    expect(result ? result.to_s : result).to eql(expected)
  end

  it do
    require_relative 'spec_9'
    x = SPEC9
    result = delete_from_bst(Tree.build_from(x[:t]), x[:queries])
    expected = x[:x] ? Tree.build_from(x[:x]).to_s : nil
    expect(result.to_s).to eql(expected)
  end

  it do
    require_relative 'spec_10'
    x = SPEC10
    result = delete_from_bst(Tree.build_from(x[:t]), x[:queries])
    expected = x[:x] ? Tree.build_from(x[:x]).to_s : nil
    expect(result.to_s).to eql(expected)
  end
end
