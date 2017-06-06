<<-DOC
Given a sorted array of integers arr and an integer num, find all possible unique subsets of arr that add up to num.
Both the array of subsets and the subsets themselves should be sorted in lexicographical order.

Example

For arr = [1, 2, 3, 4, 5] and num = 5, the output should be
sumSubsets(arr, num) = [[1, 4], [2, 3], [5]].

Input/Output

[time limit] 4000ms (rb)
[input] array.integer arr

A sorted array of integers.

Guaranteed constraints:
0 ≤ arr.length ≤ 50,
1 ≤ arr[i] ≤ num.

[input] integer num

A non-negative integer.

Guaranteed constraints:
0 ≤ num ≤ 1000.

[output] array.array.integer

A sorted array containing sorted subsets composed of elements from arr that have a sum of num. 
It is guaranteed that there are no more than 1000 subsets in the answer.
DOC

describe "sum_subsets" do
  def sum_subsets(items, target)
    head = 0
    tail = items.size - 1
    results = []
    found_target = false
    while head < tail
      x, y = items[head], items[tail]
      sum = x + y
      puts [x, y, sum].inspect
      found_target = true if x == target
      found_target = true if y == target

      if target == sum
        if found_target && x > target
          results << [target]
          found_target = false
        end
        results << [x, y]
        tail -= 1
      elsif sum > target
        tail -= 1
      elsif sum < target
        head += 1
      end
    end
    results << [target] if found_target
    results
  end

  [
    { arr: [1, 2, 3, 4, 5], num: 5, expected: [[1,4], [2,3], [5]] },
    { arr: [1, 2, 2, 3, 4, 5], num: 5, expected: [[1,2,2], [1,4], [2,3], [5]] },
    { arr: [], num: 0, expected: [[]] },
    { arr: [1, 1, 1, 1, 1, 1, 1, 1, 1], num: 9, expected: [[1,1,1,1,1,1,1,1,1]] },
    { arr: [1, 1, 2, 2, 2, 5, 5, 6, 8, 8], num: 9, expected: [[1,1,2,5], [1,2,6], [1,8], [2,2,5]] },
    { arr: [1, 1, 2, 4, 4, 4, 7, 9, 9, 13, 13, 13, 15, 15, 16, 16, 16, 19, 19, 20], num: 36, expected: [[1,1,2,4,4,4,7,13], [1,1,2,4,4,4,20], [1,1,2,4,4,9,15], [1,1,2,4,9,19], [1,1,2,4,13,15], [1,1,2,7,9,16], [1,1,2,13,19], [1,1,2,16,16], [1,1,4,4,4,7,15], [1,1,4,4,4,9,13], [1,1,4,4,7,19], [1,1,4,4,13,13], [1,1,4,15,15], [1,1,9,9,16], [1,1,15,19], [1,2,4,4,7,9,9], [1,2,4,4,9,16], [1,2,4,7,9,13], [1,2,4,9,20], [1,2,4,13,16], [1,2,7,13,13], [1,2,9,9,15], [1,2,13,20], [1,4,4,4,7,16], [1,4,4,7,20], [1,4,7,9,15], [1,4,9,9,13], [1,4,15,16], [1,7,9,19], [1,7,13,15], [1,9,13,13], [1,15,20], [1,16,19], [2,4,4,4,7,15], [2,4,4,4,9,13], [2,4,4,7,19], [2,4,4,13,13], [2,4,15,15], [2,9,9,16], [2,15,19], [4,4,4,9,15], [4,4,9,19], [4,4,13,15], [4,7,9,16], [4,13,19], [4,16,16], [7,9,20], [7,13,16], [16,20]] },
  ].each do |x|
    it do
      expect(sum_subsets(x[:arr], x[:num])).to eql(x[:expected])
    end
  end
end
