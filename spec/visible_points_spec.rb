description = <<-DOC
Given an array of points on a 2D plane, find the maximum number of points that are visible from point (0, 0) with a viewing angle that is equal to 45 degrees.

Example

For

  points = [[1, 1], [3, 1], [3, 2], [3, 3],
            [1, 3], [2, 5], [1, 5], [-1, -1],
            [-1, -2], [-2, -3], [-4, -4]]
the output should be visiblePoints(points) = 6.

This visualization shows how these 6 points can be viewed:



Input/Output

[time limit] 4000ms (rb)
[input] array.array.integer points

The array of points. For each valid i, points[i] contains exactly 2 elements and represents the ith point, where points[i][0] is the x-coordinate and points[i][1] is the y-coordinate. It is guaranteed that there are no points located at (0, 0) and there are no two points located at the same place.

Guaranteed constraints:
1 ≤ points.length ≤ 105,
1 ≤ points[i].length = 2,
-107 ≤ points[i][j] ≤ 107.

[output] integer

The maximum number of points that can be viewed from point (0, 0) with a viewing angle that is equal to 45 degrees.

NOTES

Vertex is always (0, 0)

Pythagorean theorem.

* right triangle has 90 degrees
* sum of all angles inside a triangle = 180 degrees

If we know two sides of a right triangle we can find the third side.

Hypotenuse: Long side is opposite the right angle.

A^2 + B^2 = C^2
C is the hypotenuse

Trigonometric Functions

Soh Cah Toa
sine(degrees) = Opposite (length) / Hypotenuse (length)
cosine(degrees) = Adjacent (length) / Hypotenuse (length)
tangent(degrees) = Opposite (length) / Adjacent (length)


Inverse Trigonometric Functions

sin(x) = O/H ===> x = sin-1(O/H) (inverse sine aka arcsin)
cos(x) = A/H ===> x = cos-1(A/H) (inverse cos aka arccos)
toa(x) = O/A ===> x = tan-1(O/A) (inverse tan aka arctan)

arctan(35/65) = 28.3 degrees

Math.atan(35.0/65.0) * (180 / Math::PI)
=> 28.300755766006375

DOC

describe "visible points" do
  def radians_to_degrees(radians)
    radians * (180 / Math::PI)
  end

  def degrees_to_radians(degrees)
    degrees * (Math::PI / 180)
  end

  def angle_for(x, y)
    degrees = radians_to_degrees(Math.atan(y.abs.to_f / x.abs.to_f))
    return degrees if x >= 0 && y >= 0 # quadrant 1
    return degrees + 90 if x < 0 && y > 0 # quadrant 2
    return degrees + 180 if x <= 0 && y <= 0 # quadrant 3
    return degrees + 270 if x > 0 && y <= 0 # quadrant 4

    raise [x, y].inspect
  end

  def visible_points(points, viewing_angle: 45)
    angles = points.map { |(x, y)| angle_for(x, y) }.sort
    t = max = counter = 0
    flag = false
    angles.size.times do |h|
      head = angles[h]
      loop do
        tail = angles[t]
        tail += 360 if t < h

        break if tail < head || tail > (head + viewing_angle)
        break if t == h && flag

        counter += 1
        t += 1

        if t == angles.size
          t = 0
          flag = true
        end
      end
      max = counter if counter > max
      counter -= 1
    end
    max
  end

  it do
    points = [
      [29, 12], # 22.48 degrees
      [36, -99], # 340.02 degrees (360 - 340.02 = 19.98)
    ]
    expect(visible_points(points)).to eql(2)
  end

  it do
    points = [[1, 1], [3, 1], [3, 2], [3, 3], [1, 3], [2, 5], [1, 5], [-1, -1], [-1, -2], [-2, -3], [-4, -4]]
    expect(visible_points(points)).to eql(6)
  end

  it do
    points = [[1,1], [3,1], [3,2], [3,3], [1,3], [2,5], [1,5], [-1,-1], [-1,-2], [-2,-3], [-4,-4]]
    expect(visible_points(points)).to eql(6)
  end

  it do
    points = [[5,4]]
    expect(visible_points(points)).to eql(1)
  end

  it do
    points = [[3,0], [-2,2]]
    expect(visible_points(points)).to eql(1)
  end

  it do
    points = [[-2,2], [-2,-2], [-5,0]]
    expect(visible_points(points)).to eql(2)
  end

  it do
    points = [[3,3], [-4,4], [-2,-2], [1,-1], [10,-10]]
    expect(visible_points(points)).to eql(2)
  end

  it do
    points = [[27,-88], [76,56], [-82,62], [-5,48], [-85,60], [-86,6], [-100,-54], [-22,30], [58,47], [12,80]]
    expect(visible_points(points)).to eql(3)
  end

  it do
    points = [[1, 0], [0, 1], [-1, 0], [0, -1]]
    expect(visible_points(points)).to eql(1)
  end

  it 'returns 135' do
    expect(angle_for(-2, 2)).to eql(45.0 + 90.0)
  end

  it 'returns 180' do
    expect(angle_for(-5, 0)).to eql(180.0)
  end

  it 'returns 0' do
    expect(angle_for(1, 0)).to eql(0.0)
  end

  it 'returns 90' do
    expect(angle_for(0, 1)).to eql(90.0)
  end

  it 'returns 180' do
    expect(angle_for(-1, 0)).to eql(180.0)
  end

  it 'returns 270' do
    expect(angle_for(0, -1)).to eql(270.0)
  end

  it 'spec_name' do
    [
      [1, 0, 0.0],
      [1, 1, 45.0],
      [0, 1, 90.0],
      [-1, 1, 135.0],
      [-1, 0, 180.0],
      [-1, -1, 225.0],
      [0, -1, 270.0],
      [1, -1, 315.0]
    ].each do |(x, y, expected)|
      expect(angle_for(x, y)).to eql(expected)
    end
  end

  it do
    angles = Set.new
    -100.upto(100) do |x|
      -100.upto(100) do |y|
        next if x == 0 && y == 0
        angle = angle_for(x, y).floor
        angles << angle
      end
    end
    expect(angles.count).to eql(360)
  end
end
