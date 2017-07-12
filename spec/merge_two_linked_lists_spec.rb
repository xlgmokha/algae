<<-DOC
Note: Your solution should have O(l1.length + l2.length) time complexity, since this is what you will be asked to accomplish in an interview.

Given two singly linked lists sorted in non-decreasing order, your task is to merge them. In other words, return a singly linked list, also sorted in non-decreasing order, that contains the elements from both original lists.

Example

For l1 = [1, 2, 3] and l2 = [4, 5, 6], the output should be
mergeTwoLinkedLists(l1, l2) = [1, 2, 3, 4, 5, 6];
For l1 = [1, 1, 2, 4] and l2 = [0, 3, 5], the output should be
mergeTwoLinkedLists(l1, l2) = [0, 1, 1, 2, 3, 4, 5].
Input/Output

[time limit] 4000ms (rb)
[input] linkedlist.integer l1

A singly linked list of integers.

Guaranteed constraints:
0 ≤ list size ≤ 104,
-109 ≤ element value ≤ 109.

[input] linkedlist.integer l2

A singly linked list of integers.

Guaranteed constraints:
0 ≤ list size ≤ 104,
-109 ≤ element value ≤ 109.

[output] linkedlist.integer

A list that contains elements from both l1 and l2, sorted in non-decreasing order.
DOC

describe "#merge_two_linked_lists" do
  def merge_two_linked_lists(left, right)
    return left if right.nil?
    return right if left.nil?
    result, other = left.value < right.value ? [left, right] : [right, left]
    puts [result.to_a, other.to_a].inspect

    current = result
    until other.nil?
      puts [current.value, other.value].inspect
      if current.value < other.value
        # move forward on current list
        if current.next.nil?
          current.next = other
          break
        else
          current = current.next
        end
      else
        # take node from other
        break
      end
    end

    result
  end

  [
    { l1: [1, 2, 3], l2: [4, 5, 6], x: [1, 2, 3, 4, 5, 6] },
    { l1: [1, 1, 2, 4], l2: [0, 3, 5], x: [0, 1, 1, 2, 3, 4, 5] },
    { l1: [5, 10, 15, 40], l2: [2, 3, 20], x: [2, 3, 5, 10, 15, 20, 40] },
    { l1: [1, 1], l2: [2, 4], x: [1, 1, 2, 4] },
    { l1: [], l2: [1, 1, 2, 2, 4, 7, 7, 8], x: [1, 1, 2, 2, 4, 7, 7, 8] },
    { l1: [], l2: [], x: [] },
    { l1: [1, 1, 4], l2: [], x: [1, 1, 4] },
    { l1: [1, 1], l2: [0], x: [0, 1, 1] },
    { l1: [0], l2: [2], x: [0, 2] },
    { l1: [1], l2: [-1000000000, 1000000000], x: [-1000000000, 1, 1000000000] },
    { l1: [-1, -1, 0, 1], l2: [-1, 0, 0, 1, 1], x: [-1, -1, -1, 0, 0, 0, 1, 1, 1] },
    { l1: [-780990573, -670826849, -404817961, 242026249, 731519938], l2: [-815817641, -426491047, 437929670, 520408640], x: [-815817641, -780990573, -670826849, -426491047, -404817961, 242026249, 437929670, 520408640, 731519938] },
  ].each do |x|
    it do
      result = merge_two_linked_lists(ListNode.to_list(x[:l1]), ListNode.to_list(x[:l2])).to_a
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
