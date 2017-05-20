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

  # function to find third point in angle
  def angle_for(x, y)
    radians_to_degrees(Math.atan(y.to_f / x.to_f))
  end

  def valid_angles_for(points)
    points.inject([]) do |angles, (x, y)|
      return angles if x == 0 && y == 0
      return angles if x < 0 || y < 0
      angle = angle_for(x, y)
      return angles if angle > 45.0
      angles.push(angle)
      angles
    end
  end

  def visible_points(points)
    angles = valid_angles_for(points)
    puts angles.inspect
  end

  it do
    points = [[1, 1], [3, 1], [3, 2], [3, 3], [1, 3], [2, 5], [1, 5], [-1, -1], [-1, -2], [-2, -3], [-4, -4]]
    expect(visible_points(points)).to eql(6)
  end

  #it do
    #points = [[1,1], [3,1], [3,2], [3,3], [1,3], [2,5], [1,5], [-1,-1], [-1,-2], [-2,-3], [-4,-4]]
    #expect(visible_points(points)).to eql(6)
  #end
end
