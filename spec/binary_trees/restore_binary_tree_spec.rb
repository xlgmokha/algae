<<-DOC
Note: Your solution should have O(inorder.length) complexity, since this is what you will be asked to accomplish in an interview.

Let's define inorder and preorder traversals of a binary tree as follows:

Inorder traversal first visits the left subtree, then the root, then its right subtree;
Preorder traversal first visits the root, then its left subtree, then its right subtree.
For example, if tree looks like this:

    1
   / \
  2   3
 /   / \
4   5   6
then the traversals will be as follows:

Inorder traversal: [4, 2, 1, 5, 3, 6]
Preorder traversal: [1, 2, 4, 3, 5, 6]
Given the inorder and preorder traversals of a binary tree t, but not t itself, restore t and return it.

Example

For inorder = [4, 2, 1, 5, 3, 6] and preorder = [1, 2, 4, 3, 5, 6], the output should be
restoreBinaryTree(inorder, preorder) = {
    "value": 1,
    "left": {
        "value": 2,
        "left": {
            "value": 4,
            "left": null,
            "right": null
        },
        "right": null
    },
    "right": {
        "value": 3,
        "left": {
            "value": 5,
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
For inorder = [2, 5] and preorder = [5, 2], the output should be
restoreBinaryTree(inorder, preorder) = {
    "value": 5,
    "left": {
        "value": 2,
        "left": null,
        "right": null
    },
    "right": null
}
Input/Output

[time limit] 4000ms (rb)
[input] array.integer inorder

An inorder traversal of the tree. It is guaranteed that all numbers in the tree are pairwise distinct.

Guaranteed constraints:
1 ≤ inorder.length ≤ 2 · 103,
-105 ≤ inorder[i] ≤ 105.

[input] array.integer preorder

A preorder traversal of the tree.

Guaranteed constraints:
preorder.length = inorder.length,
-105 ≤ preorder[i] ≤ 105.

[output] tree.integer

The restored binary tree.
http://www.geeksforgeeks.org/construct-tree-from-given-inorder-and-preorder-traversal/
DOC

describe "#restore_binary_tree" do
  $preorder_index = 0

  def restore_binary_tree(inorder, preorder, start_index = 0, end_index = inorder.size - 1)
    return nil if start_index > end_index

    value = preorder[$preorder_index]
    node = { value: value, left: nil, right: nil }
    $preorder_index += 1

    return node if start_index == end_index

    index = inorder[start_index..end_index].index(value) + start_index
    node[:left] = restore_binary_tree(inorder, preorder, start_index, index - 1)
    node[:right] = restore_binary_tree(inorder, preorder, index + 1, end_index)
    node
  end

  null = nil
  [
    { inorder: [4, 2, 1, 5, 3, 6], preorder: [1, 2, 4, 3, 5, 6], x: { "value": 1, "left": { "value": 2, "left": { "value": 4, "left": null, "right": null }, "right": null }, "right": { "value": 3, "left": { "value": 5, "left": null, "right": null }, "right": { "value": 6, "left": null, "right": null } } } },
    { inorder: [2, 5], preorder: [5, 2], x: { "value": 5, "left": { "value": 2, "left": null, "right": null }, "right": null } },
    { inorder: [100], preorder: [100], x: { "value": 100, "left": null, "right": null } },
    { inorder: [-100000, -99999, -99998], preorder: [-99999, -100000, -99998], x: { "value": -99999, "left": { "value": -100000, "left": null, "right": null }, "right": { "value": -99998, "left": null, "right": null } } },
  ].each do |x|
    it do
      $preorder_index = 0
      expect(restore_binary_tree(x[:inorder], x[:preorder])).to eql(x[:x])
    end
  end
end
