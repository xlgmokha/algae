<<-DOC
Note: Try to solve this task in O(n) time using O(1) additional space, where n is the number of elements in the list, since this is what you'll be asked to do during an interview.

Given a singly linked list of integers l and an integer k, remove all elements from list l that have a value equal to k.

Example

For l = [3, 1, 2, 3, 4, 5] and k = 3, the output should be
removeKFromList(l, k) = [1, 2, 4, 5];
For l = [1, 2, 3, 4, 5, 6, 7] and k = 10, the output should be
removeKFromList(l, k) = [1, 2, 3, 4, 5, 6, 7].
Input/Output

[time limit] 4000ms (rb)
[input] linkedlist.integer l

A singly linked list of integers.

Guaranteed constraints:
0 ≤ list size ≤ 105,
-1000 ≤ element value ≤ 1000.

[input] integer k

An integer.

Guaranteed constraints:
-1000 ≤ k ≤ 1000.

[output] linkedlist.integer

Return l with all the values equal to k removed.
DOC

describe "remove_k_from_list" do
  def remove_k_from_list(head, target)
    current = head
    previous = nil

    until current.nil?
      if current.value == target
        if previous.nil?
          head = current.next
          current = head
        else
          previous.next = current.next
          current = current.next
        end
      else
        previous = current
        current = current.next
      end
    end
    head
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
  end

  def to_list(items)
    x = nil
    items.inject(nil) do |memo, item|
      node = ListNode.new(item)
      if memo.nil?
        x = node
      else
        memo.next = node
      end
      node
    end
    x
  end

  [
    { l: [3, 1, 2, 3, 4, 5], k: 3, x: [1, 2, 4, 5] },
    { l: [1, 2, 3, 4, 5, 6, 7], k: 10, x: [1, 2, 3, 4, 5, 6, 7] },
    { l: [1000, 1000], k: 1000, x: [] },
    { l: [], k: -1000, x: [] },
    { l: [123, 456, 789, 0], k: 0, x: [123, 456, 789] },
  ].each do |x|
    it do
      list = to_list(x[:l])
      expect(remove_k_from_list(list, x[:k]).to_a).to eql(x[:x])
    end
  end
end
