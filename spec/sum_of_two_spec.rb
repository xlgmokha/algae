<<-DOC
You have two integer arrays, a and b, and an integer target value v.
Determine whether there is a pair of numbers, where one number is taken from a and the other from b, that can be added together to get a sum of v.
Return true if such a pair exists, otherwise return false.

Example

For a = [1, 2, 3], b = [10, 20, 30, 40], and v = 42, the output should be
sumOfTwo(a, b, v) = true.

Input/Output

[time limit] 4000ms (rb)
[input] array.integer a

An array of integers.

Guaranteed constraints:
0 ≤ a.length ≤ 105,
-109 ≤ a[i] ≤ 109.

[input] array.integer b

An array of integers.

Guaranteed constraints:
0 ≤ b.length ≤ 105,
-109 ≤ b[i] ≤ 109.

[input] integer v

Guaranteed constraints:
-109 ≤ v ≤ 109.

[output] boolean

true if there are two elements from a and b which add up to v, and false otherwise.
DOC

describe "sum_of_two" do
  # time: nlogn
  def sum_of_two(a, b, v)
    outer, inner =  a.size > b.size ? [b.sort, a.sort] : [a.sort, b.sort]
    outer.any? { |i| inner.bsearch { |x| (v - i) <=> x } }
  end

  # time: n
  def sum_of_two(a, b, v)
    hash = {}
    a.each { |x| hash[x] = true }
    b.any? { |x| hash[v - x] }
  end

  def sum_of_two(a, b, v)
    (a.map { |x| v - x } & b).size > 0
  end

  [
    { a: [1, 2, 3], b: [10, 20, 30, 40], v: 42, expected: true },
    { a: [1, 2, 3], b: [10, 20, 30, 40], v: 50, expected: false },
    { a: [], b: [1, 2, 3, 4], v: 4, expected: false },
    { a: [10, 1, 5, 3, 8], b: [100, 6, 3, 1, 5], v: 4, expected: true },
    { a: [1, 4, 3, 6, 10, 1, 0, 1, 6, 5], b: [9, 5, 6, 9, 0, 1, 2, 1, 6, 10], v: 8, expected: true },
    { a: [3, 2, 3, 7, 5, 0, 3, 0, 4, 2], b: [6, 8, 2, 9, 7, 10, 3, 8, 6, 0], v: 2, expected: true },
    { a: [4, 6, 4, 2, 9, 6, 6, 2, 9, 2], b: [3, 4, 5, 1, 4, 10, 9, 9, 6, 4], v: 5, expected: true },
    { a: [6, 10, 25, 13, 20, 21, 11, 10, 18, 21], b: [21, 10, 6, 0, 29, 25, 1, 17, 19, 25], v: 37, expected: true },
    { a: [22, 26, 6, 22, 17, 11, 9, 22, 7, 12], b: [14, 25, 22, 27, 22, 30, 6, 26, 30, 27], v: 56, expected: true },
    { a: [17, 72, 18, 72, 73, 15, 83, 90, 8, 18], b: [100, 27, 33, 51, 2, 71, 76, 19, 16, 43], v: 37, expected: true },
  ].each do |x|
    it do
      expect(sum_of_two(x[:a], x[:b], x[:v])).to eql(x[:expected])
    end
  end

end
