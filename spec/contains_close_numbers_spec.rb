<<-DOC
Given an array of integers nums and an integer k,
determine whether there are two distinct indices i and j
in the array where nums[i] = nums[j] and the
absolute difference between i and j is less than or equal to k.

Example

For nums = [0, 1, 2, 3, 5, 2] and k = 3, the output should be
containsCloseNums(nums, k) = true.

There are two 2s in nums, and the absolute difference between their positions is exactly 3.

For nums = [0, 1, 2, 3, 5, 2] and k = 2, the output should be

containsCloseNums(nums, k) = false.

The absolute difference between the positions of the two 2s is 3, which is more than k.

Input/Output

[time limit] 4000ms (rb)
[input] array.integer nums

Guaranteed constraints:
0 ≤ nums.length ≤ 55000,
-231 - 1 ≤ nums[i] ≤ 231 - 1.

[input] integer k

Guaranteed constraints:
0 ≤ k ≤ 35000.

[output] boolean
DOC

describe "#contains_close_numbers" do
  def diff(x)
    1.upto(x.size - 1).map { |n| (x[n] - x[n-1]).abs }
  end

  def contains_close_numbers(numbers, k)
    return numbers[0] == numbers[1] if numbers.size == 2

    items = Hash.new { |hash, key| hash[key] = [] }
    numbers.each_with_index do |number, index|
      items[number].push(index)
      return true if diff(items[number]).include?(k)
    end

    false
  end

  [
    { nums: [0, 1, 2, 3, 5, 2], k: 3, x: true },
    { nums: [0, 1, 2, 3, 5, 2], k: 2, x: false },
    { nums: [], k: 0, x: false },
    { nums: [99, 99], k: 2, x: true },
    { nums: [2, 2], k: 3, x: true },
    { nums: [1, 2], k: 2, x: false },
    { nums: [1, 2, 1], k: 2, x: true },
    { nums: [1, 0, 1, 1], k: 1, x: true },
    { nums: [1, 2, 1], k: 0, x: false },
    { nums: [1, 2, 1], k: 1, x: false },
    { nums: [1], k: 1, x: false },
    { nums: [-1, -1], k: 1, x: true },
  ].each do |x|
    it do
      expect(contains_close_numbers(x[:nums], x[:k])).to eql(x[:x])
    end
  end
end
