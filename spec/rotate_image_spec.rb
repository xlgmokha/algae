<<-DOC 
Note: Try to solve this task in-place (with O(1) additional memory), since this is what you'll be asked to do during an interview.

You are given an n x n 2D matrix that represents an image. Rotate the image by 90 degrees (clockwise).

Example

For

a = [[1, 2, 3],
     [4, 5, 6],
     [7, 8, 9]]
the output should be

rotateImage(a) =
    [[7, 4, 1],
     [8, 5, 2],
     [9, 6, 3]]
Input/Output

[time limit] 4000ms (rb)
[input] array.array.integer a

Guaranteed constraints:
1 ≤ a.length ≤ 100,
a[i].length = a.length,
1 ≤ a[i][j] ≤ 104.

[output] array.array.integer
DOC

describe "rotate_image" do
  def rotate_image(image)
    copy = Array.new(image.size) { Array.new }

    0.upto(image.size - 1) do |i|
      (image.size - 1).downto(0) do |j|
        copy[i].push(image[j][i])
      end
    end
    copy
  end

  def rotate_image(image)
    image.reverse!.transpose
  end

  def reverse(image)
    head = 0
    tail = image.size - 1

    until head == tail || head > tail
      image[head], image[tail] = image[tail], image[head]
      head += 1
      tail -= 1
    end
    image
  end

  def transpose(image)
    copy = Array.new(image[0].size) { Array.new }
    i = 0
    until image.empty?
      image.each do |row|
        copy[i].push(row.shift)
      end
      i += 1
      break if i == image.size
    end
    copy
  end

  def rotate_image(image)
    transpose(reverse(image))
  end

  def rotate_image(image)
    image.reverse!
    (0...image.size).each do |i|
      (i + 1...image.size).each do |j|
        image[i][j], image[j][i] = image[j][i], image[i][j]
      end
    end
    image
  end

  [
    { a: [[1,2,3], [4,5,6], [7,8,9]], x: [[7,4,1], [8,5,2], [9,6,3]] },
    { a: [[1]], x: [[1]] },
    { a: [[10,9,6,3,7], [6,10,2,9,7], [7,6,3,8,2], [8,9,7,9,9], [6,8,6,8,2]], x: [[6,8,7,6,10], [8,9,6,10,9], [6,7,3,2,6], [8,9,8,9,3], [2,9,2,7,7]] },
    { a: [[40,12,15,37,33,11,45,13,25,3], [37,35,15,43,23,12,22,29,46,43], [44,19,15,12,30,2,45,7,47,6], [48,4,40,10,16,22,18,36,27,48], [45,17,36,28,47,46,8,4,17,3], [14,9,33,1,6,31,7,38,25,17], [31,9,17,11,29,42,38,10,48,6], [12,13,42,3,47,24,28,22,3,47], [38,23,26,3,23,27,14,40,15,22], [8,46,20,21,35,4,36,18,32,3]], x: [[8,38,12,31,14,45,48,44,37,40], [46,23,13,9,9,17,4,19,35,12], [20,26,42,17,33,36,40,15,15,15], [21,3,3,11,1,28,10,12,43,37], [35,23,47,29,6,47,16,30,23,33], [4,27,24,42,31,46,22,2,12,11], [36,14,28,38,7,8,18,45,22,45], [18,40,22,10,38,4,36,7,29,13], [32,15,3,48,25,17,27,47,46,25], [3,22,47,6,17,3,48,6,43,3]] },
    { a: [[33,35,8,24,19,1,3,1,4,5], [25,27,40,25,17,35,20,3,19,3], [9,1,9,30,9,25,32,12,15,22], [30,47,25,10,18,1,19,17,43,17], [40,46,42,34,18,48,29,40,31,39], [37,42,37,19,45,1,4,46,48,13], [8,26,31,46,44,24,34,29,12,25], [45,48,36,12,33,12,4,45,22,37], [33,15,34,25,34,8,50,48,30,28], [18,19,22,29,15,43,38,30,8,47]], x: [[18,33,45,8,37,40,30,9,25,33], [19,15,48,26,42,46,47,1,27,35], [22,34,36,31,37,42,25,9,40,8], [29,25,12,46,19,34,10,30,25,24], [15,34,33,44,45,18,18,9,17,19], [43,8,12,24,1,48,1,25,35,1], [38,50,4,34,4,29,19,32,20,3], [30,48,45,29,46,40,17,12,3,1], [8,30,22,12,48,31,43,15,19,4], [47,28,37,25,13,39,17,22,3,5]] }
  ].each do |x|
    it do
      expect(rotate_image(x[:a])).to eql(x[:x])

    end
  end
end
