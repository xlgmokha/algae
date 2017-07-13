<<-DOC
Note: Try to solve this task in O(list size) time using O(1) additional space, since this is what you'll be asked during an interview.

Given a singly linked list of integers l and a non-negative integer n,
move the last n list nodes to the beginning of the linked list.

Example

For l = [1, 2, 3, 4, 5] and n = 3, the output should be
rearrangeLastN(l, n) = [3, 4, 5, 1, 2];
For l = [1, 2, 3, 4, 5, 6, 7] and n = 1, the output should be
rearrangeLastN(l, n) = [7, 1, 2, 3, 4, 5, 6].
Input/Output

[time limit] 4000ms (rb)
[input] linkedlist.integer l

A singly linked list of integers.

Guaranteed constraints:
0 ≤ list size ≤ 105,
-1000 ≤ element value ≤ 1000.

[input] integer n

A non-negative integer.

Guaranteed constraints:
0 ≤ n ≤ list size.

[output] linkedlist.integer

Return l with the n last elements moved to the beginning.
DOC

describe "#rearrange_last_n" do
  def length_of(list)
    i = 1
    i += 1 while list = list.next
    i
  end

  def rearrange_last_n(list, n)
    return list if n.zero?
    length = length_of(list)
    return list if n == length

    position = length - n
    head = mid = tail = list

    tail = tail.next until tail.next.nil?
    (position - 1).times { mid = mid.next }
    nh = mid.next
    mid.next = nil
    tail.next = head

    nh
  end

  [
    { l: [1, 2, 3, 4, 5], n: 3, x: [3, 4, 5, 1, 2] },
    { l: [1, 2, 3, 4, 5, 6, 7], n: 1, x: [7, 1, 2, 3, 4, 5, 6] },
    { l: [1000, -1000], n: 0, x: [1000, -1000] },
    { l: [], n: 0, x: [] },
    { l: [123, 456, 789, 0], n: 4, x: [123, 456, 789, 0] },
  ].each do |x|
    it do
      result = rearrange_last_n(ListNode.to_list(x[:l]), x[:n])
      expect(result.to_a).to eql(x[:x])
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
