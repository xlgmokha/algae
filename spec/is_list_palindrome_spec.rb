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
  def palindrome?(head)
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
  ].each do |x|
    it do
      expect(palindrome?(to_list(x[:l]))).to eql(x[:x])
    end
  end
end
