<<-DOC
Note: Your solution should have O(n) time complexity, where n is the number of element in l, and O(1) additional space complexity, since this is what you would be asked to accomplish in an interview.

Given a linked list l, reverse its nodes k at a time and return the modified list. k is a positive integer that is less than or equal to the length of l. If the number of nodes in the linked list is not a multiple of k, then the nodes that are left out at the end should remain as-is.

You may not alter the values in the nodes - only the nodes themselves can be changed.

Example

For l = [1, 2, 3, 4, 5] and k = 2, the output should be
reverseNodesInKGroups(l, k) = [2, 1, 4, 3, 5];
For l = [1, 2, 3, 4, 5] and k = 1, the output should be
reverseNodesInKGroups(l, k) = [1, 2, 3, 4, 5];
For l = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11] and k = 3, the output should be
reverseNodesInKGroups(l, k) = [3, 2, 1, 6, 5, 4, 9, 8, 7, 10, 11].
Input/Output

[time limit] 4000ms (rb)
[input] linkedlist.integer l

A singly linked list of integers.

Guaranteed constraints:
1 ≤ list size ≤ 104,
-109 ≤ element value ≤ 109.

[input] integer k

The size of the groups of nodes that need to be reversed.

Guaranteed constraints:
1 ≤ k ≤ l size.

[output] linkedlist.integer

The initial list, with reversed groups of k elements.
DOC

describe "#reverse_nodes_in_k_groups" do
  def reverse_nodes_in_k_groups(head, k)
    head
  end

  [
    { l: [1, 2, 3, 4, 5], k: 2, x: [2, 1, 4, 3, 5] },
    { l: [1, 2, 3, 4, 5], k: 1, x: [1, 2, 3, 4, 5] },
    { l: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], k: 3, x: [3, 2, 1, 6, 5, 4, 9, 8, 7, 10, 11] },
    { l: [239], k: 1, x: [239] },
    { l: [1, 2, 3, 4], k: 2, x: [2, 1, 4, 3] },
    { l: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], k: 3, x: [3, 2, 1, 6, 5, 4, 9, 8, 7, 12, 11, 10] },
    { l: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], k: 4, x: [4, 3, 2, 1, 8, 7, 6, 5, 12, 11, 10, 9] },
    { l: [1000000000, -849483855, -1000000000, 376365554, -847904832], k: 4, x: [376365554, -1000000000, -849483855, 1000000000, -847904832] },
    { l: [376365554, -340557143, -849483855, 810952169, -847904832], k: 4, x: [810952169, -849483855, -340557143, 376365554, -847904832] },
    { l: [810952169, -849483855, -340557143, 376365554, -847904832], k: 2, x: [-849483855, 810952169, 376365554, -340557143, -847904832] },
    { l: [-503549928, -526666356, 262916773, -508129645, 992040586, 867794712, 24042453, -540165420, -417669299, 766910780], k: 2, x: [-526666356, -503549928, -508129645, 262916773, 867794712, 992040586, -540165420, 24042453, 766910780, -417669299] },
    { l: [-526666356, -503549928, -508129645, 262916773, 867794712, 992040586, -540165420, 24042453, 766910780, -417669299], k: 8, x: [24042453, -540165420, 992040586, 867794712, 262916773, -508129645, -503549928, -526666356, 766910780, -417669299] },
    { l: [24042453, -540165420, 992040586, 867794712, 262916773, -508129645, -503549928, -526666356, 766910780, -417669299], k: 6, x: [-508129645, 262916773, 867794712, 992040586, -540165420, 24042453, -503549928, -526666356, 766910780, -417669299] },
  ].each do |x|
    it do
      result = reverse_nodes_in_k_groups(ListNode.to_list(x[:l]), x[:k]).to_a
      expect(result).to eql(x[:x])
    end
  end

  class ListNode
    attr_accessor :value, :next

    def initialize(value, next_node: nil)
      @value = value
      @next = next_node
    end

    def to_a
      result = []
      current = self
      until current.nil?
        result.push(current.value)
        current = current.next
      end
      result
    end

    def self.to_list(items)
      x = nil
      items.inject(nil) do |memo, item|
        node = new(item)
        if memo.nil?
          x = node
        else
          memo.next = node
        end
        node
      end
      x
    end
  end
end
