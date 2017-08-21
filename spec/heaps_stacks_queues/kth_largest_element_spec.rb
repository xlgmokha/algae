<<-DOC
Find the kth largest element in an unsorted array. This will be the kth largest element in sorted order, not the kth distinct element.

Example

For nums = [7, 6, 5, 4, 3, 2, 1] and k = 2, the output should be
kthLargestElement(nums, k) = 6;
For nums = [99, 99] and k = 1, the output should be
kthLargestElement(nums, k) = 99.
Input/Output

[time limit] 4000ms (rb)
[input] array.integer nums

Guaranteed constraints:
1 ≤ nums.length ≤ 105,
-105 ≤ nums[i] ≤ 105.

[input] integer k

Guaranteed constraints:
1 ≤ k ≤ nums.length.

[output] integer
DOC

describe "#kth_largest_element" do
  def kth_largest_element(numbers, k)
    numbers.sort[-k]
  end

  #def kth_largest_element(numbers, k)
    #items = Array.new(105)
    #numbers.each do |n|
      #items[n] = n
    #end
    #items.compact[-k]
  #end

  def kth_largest_element(numbers, k)
    return numbers[0] if numbers.size == 1

    numbers.shuffle!
    partition = numbers[0]
    upper = numbers[1..-1].find_all { |x| x >= partition }

    if upper.size >= k
      kth_largest_element(upper, k)
    else
      lower = numbers[1..-1].find_all { |x| x < partition } + [partition]
      kth_largest_element(lower, k - upper.size)
    end
  end

  [
    { nums: [7, 6, 5, 4, 3, 2, 1], k: 2, x: 6 },
    { nums: [99, 99], k: 1, x: 99 },
    { nums: [1], k: 1, x: 1 },
    { nums: [2, 1], k: 1, x: 2 },
    { nums: [-1, 2, 0], k: 2, x: 0 },
    { nums: [-1, 2, 0], k: 3, x: -1 },
    { nums: [3, 1, 2, 4], k: 2, x: 3 },
    { nums: [3, 2, 1, 5, 6, 4], k: 2, x: 5 },
    { nums: [5, 2, 4, 1, 3, 6, 0], k: 2, x: 5 },
    { nums: [3, 3, 3, 3, 3, 3, 3, 3, 3], k: 8, x: 3 },
    { nums: [3, 3, 3, 3, 4, 3, 3, 3, 3], k: 1, x: 4 },
    { nums: [3, 3, 3, 3, 4, 3, 3, 3, 3], k: 5, x: 3 },
    { nums: [3, 2, 3, 1, 2, 4, 5, 5, 6], k: 4, x: 4 },
    { nums: [3, 2, 3, 1, 2, 4, 5, 5, 6, 7, 7, 8, 2, 3, 1, 1, 1, 10, 11, 5, 6, 2, 4, 7, 8, 5, 6], k: 1, x: 11 },
    { nums: [2, 1], k: 2, x: 1 },
    { nums: [-1, -1], k: 2, x: -1 },
  ].each do |x|
    it do
      expect(kth_largest_element(x[:nums], x[:k])).to eql(x[:x])
    end
  end

end
