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
DOC

  def rightmost(tree)
    return nil if tree.nil?

    tree.right.nil? ? tree : rightmost(tree.right)
  end

  def parent_of(tree, target)
    return nil if tree.nil?

    return tree if tree.right && target == tree.right.value
    parent_of(tree.right)
  end

  def remove(tree, target)
    return nil if tree.nil?

    if target == tree.value
      if tree.left
        new_root = rightmost(tree.left)
        old_parent = parent_of(tree.left, new_root.value)
        old_parent&.right = nil
        new_root.left = tree.left
        new_root.right = tree.right
        tree = new_root
      else
        tree.right
      end
    else
      tree.left = remove(tree.left, target)
      tree.right = remove(tree.right, target)
    end
    tree
  end

  def delete_from_bst(tree, queries)
    return tree if tree.nil?
    tree.print

    queries.each do |query|
      tree = remove(tree, query)
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
  ].each do |x|
    it do
      result = delete_from_bst(Tree.build_from(x[:t]), x[:queries])
      puts x[:queries].inspect
      result.print
      expect(result.to_h).to eql(x[:x])
    end
  end
end
