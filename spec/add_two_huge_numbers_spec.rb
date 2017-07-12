<<-DOC
You're given 2 huge integers represented by linked lists.
Each linked list element is a number from 0 to 9999 that
represents a number with exactly 4 digits.
The represented number might have leading zeros.
Your task is to add up these huge integers and
return the result in the same format.

Example

For a = [9876, 5432, 1999] and b = [1, 8001], the output should be
addTwoHugeNumbers(a, b) = [9876, 5434, 0].

Explanation: 987654321999 + 18001 = 987654340000.

For a = [123, 4, 5] and b = [100, 100, 100], the output should be
addTwoHugeNumbers(a, b) = [223, 104, 105].

Explanation: 12300040005 + 10001000100 = 22301040105.

Input/Output

[time limit] 4000ms (rb)
[input] linkedlist.integer a

The first number, without its leading zeros.

Guaranteed constraints:
0 ≤ a size ≤ 104,
0 ≤ element value ≤ 9999.

[input] linkedlist.integer b

The second number, without its leading zeros.

Guaranteed constraints:
0 ≤ b size ≤ 104,
0 ≤ element value ≤ 9999.

[output] linkedlist.integer

The result of adding a and b together, returned without leading zeros in the same format.
DOC

describe "#add_two_huge_numbers" do
  def to_number(head)
    number, x = [head.value.to_s.rjust(4, '0')], head
    number.push(x.value.to_s.rjust(4, '0')) while x = x.next
    number.join.to_i
  end

  def add_two_huge_numbers(a, b)
    x, y = to_number(a), to_number(b)
    sum = x + y
    chunks = sum.to_s.chars.reverse.each_slice(4).to_a.reverse.map(&:reverse)
    chunks.map(&:join).map(&:to_i).to_a
  end

  [
    { a: [9876, 5432, 1999], b: [1, 8001], x: [9876, 5434, 0] },
    { a: [123, 4, 5], b: [100, 100, 100], x: [223, 104, 105] },
    { a: [0], b: [0], x: [0] },
    { a: [1234, 1234, 0], b: [0], x: [1234, 1234, 0] },
    { a: [0], b: [1234, 123, 0], x: [1234, 123, 0] },
    { a: [1], b: [9998, 9999, 9999, 9999, 9999, 9999], x: [9999, 0, 0, 0, 0, 0] },
    { a: [1], b: [9999, 9999, 9999, 9999, 9999, 9999], x: [1, 0, 0, 0, 0, 0, 0] },
    { a: [8339, 4510], b: [2309], x: [8339, 6819] },
  ].each do |x|
    it do
      expect(add_two_huge_numbers(
        ListNode.to_list(x[:a]), ListNode.to_list(x[:b])
      )).to eql(x[:x].to_a)
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
