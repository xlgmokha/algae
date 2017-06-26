<<-DOC
Note: Write a solution with O(n) time complexity and O(1) additional space complexity, 
since this is what you would be asked to do during a real interview.

Given an array a that contains only numbers in the range from 1 to a.length,
find the first duplicate number for which the second occurrence has the minimal index.
In other words, if there are more than 1 duplicated numbers, 
return the number for which the second occurrence has a smaller index than the second occurrence of the other number does. 
If there are no such elements, return -1.

Example

For a = [2, 3, 3, 1, 5, 2], the output should be
firstDuplicate(a) = 3.

There are 2 duplicates: numbers 2 and 3. The second occurrence of 3 has a smaller index than than second occurrence of 2 does, 
so the answer is 3.

For a = [2, 4, 3, 5, 1], the output should be
firstDuplicate(a) = -1.

Input/Output

[time limit] 4000ms (rb)
[input] array.integer a

Guaranteed constraints:
1 ≤ a.length ≤ 105,
1 ≤ a[i] ≤ a.length.

[output] integer

The element in a that occurs in the array more than once and has the minimal index for its second occurrence. 
If there are no such elements, return -1.
DOC

describe "first_duplicate" do
  def first_duplicate(items)
    head, tail = 0, 1
    min = -1
    n = items.size

    until head == (n - 1) || head == min
      puts [items[head], items[tail]].inspect
      if items[head] == items[tail]
        min = min < 0 ?  tail + 1 : [min, tail + 1].min
        puts ['match', items[head], items[tail], min].inspect
        head += 1
        tail = head + 1
        break if tail == head
      else
        tail += 1
        break if min >= 0 && tail > min
        if tail == n
          head += 1
          tail = head + 1
        end
      end
    end
    min > 0 ? items[min - 1] : min
  end

  [
    { a: [2, 3, 3, 1, 5, 2], x: 3 },
    { a: [2, 4, 3, 5, 1], x: -1 },
    { a: [1], x: -1 },
    { a: [2, 2], x: 2 },
    { a: [2, 1], x: -1 },
    { a: [2, 1, 3], x: -1 },
    { a: [2, 3, 3], x: 3 },
    { a: [3, 3, 3], x: 3 },
    { a: [8, 4, 6, 2, 6, 4, 7, 9, 5, 8], x: 6 },
    { a: [10, 6, 8, 4, 9, 1, 7, 2, 5, 3], x: -1 },
  ].each do |x|
    it do
      expect(first_duplicate(x[:a])).to eql(x[:x])
    end
  end
end
