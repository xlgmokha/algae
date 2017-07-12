<<-DOC
Given a singly linked list of integers, determine whether or not it's a palindrome.

Example

For l = [0, 1, 0], the output should be
isListPalindrome(l) = true;
For l = [1, 2, 2, 3], the output should be
isListPalindrome(l) = false.
Input/Output

[time limit] 4000ms (rb)
[input] linkedlist.integer l

A singly linked list of integers.

Guaranteed constraints:
0 ≤ list size ≤ 5 · 10^5,
-10^9 ≤ element value ≤ 10^9.

[output] boolean

Return true if l is a palindrome, otherwise return false.
DOC

describe "is_list_palindrome" do
  def length_of(head)
    i = 0
    until head.nil?
      i += 1
      head = head.next
    end
    i
  end

  def palindrome?(head)
    return true if head.nil?

    length = length_of(head)
    mid = length.even? ? length / 2 : (length / 2) + 1
    distance_travelled = 0
    left_sum, right_sum = 0, 0

    node = head
    until node.nil?
      if distance_travelled >= mid
        right_sum += node.value
      else
        left_sum += node.value
      end
      distance_travelled += 1
      node = node.next
    end

    if length.even?
      left_sum - right_sum == 0
    else
      left_sum - right_sum == 1
    end
  end

  def advance_to(head, index)
    return head if index == 0

    advance_to(head.next, index - 1)
  end

  def reverse(head)
    new_root = nil
    root = head

    while root
      x = root.next
      root.next = new_root
      new_root = root
      root = x
    end

    new_root
  end

  def palindrome?(head)
    return true if head.nil?
    length = length_of(head)
    mid = length / 2

    x, y = head, reverse(advance_to(head, mid))
    0.upto(mid - 1) do |i|
      return false unless x.value == y.value
      x, y = x.next, y.next
    end
    true
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
    { l: [0, 1, 0], x: true },
    { l: [1, 2, 2, 3], x: false },
    { l: [1, 1000000000, -1000000000, -1000000000, 1000000000, 1], x: true },
    { l: [1, 2, 3, 3, 2], x: false },
    { l: [1, 2, 3, 1, 2, 3], x: false },
    { l: [], x: true },
    { l: [3, 5, 3, 5], x: false },
    { l: [1, 5, 2, 4], x: false },
    { l: [10], x: true },
    { l: [0, 0], x: true },
    { l: [1, 3, 2, 2, 2], x: false },
  ].each do |x|
    it do
      expect(palindrome?(to_list(x[:l]))).to eql(x[:x])
    end
  end
end
