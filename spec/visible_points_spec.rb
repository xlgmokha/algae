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
  class ViewingAngle
    attr_reader :top, :bottom

    def initialize(top:, bottom:)
      @top = top
      @bottom = bottom
    end

    def visible?(points)
      points.find_all do |(x, y)|
        angle = self.class.angle_for(x, y)
        angle <= top && angle >= bottom
      end.count
    end

    def inspect
      [top, bottom].inspect
    end

    def ==(other)
      top == other.top && bottom == other.bottom
    end

    def self.radians_to_degrees(radians)
      radians * (180 / Math::PI)
    end

    def self.degrees_to_radians(degrees)
      degrees * (Math::PI / 180)
    end

    def self.angle_for(x, y)
      degrees = radians_to_degrees(Math.atan(y.abs.to_f / x.abs.to_f))
      if x >= 0 && y >= 0
        return degrees
      end
      if x < 0 && y > 0
        return degrees + 90
      end
      if x < 0 && y <= 0
        return degrees + 180
      end
      if x > 0 && y <= 0
        return degrees + 270
      end
    end
  end

  def viewing_angle_for(x, y)
    lower_angle = ViewingAngle.angle_for(x, y)
    ViewingAngle.new(top: lower_angle + 45, bottom: lower_angle)
  end

  def valid_viewing_angles_for(points)
    angles = [
      ViewingAngle.new(top: 45.0, bottom: 0.0),
      ViewingAngle.new(top: 90.0, bottom: 45.0),
      ViewingAngle.new(top: 135.0, bottom: 90.0),
      ViewingAngle.new(top: 180.0, bottom: 135.0),
      ViewingAngle.new(top: 225.0, bottom: 180.0),
      ViewingAngle.new(top: 270.0, bottom: 225.0),
      ViewingAngle.new(top: 315.0, bottom: 270.0),
      ViewingAngle.new(top: 360.0, bottom: 315.0),
    ]
    points.each do |(x, y)|
      next if x == 0 && y == 0
      angle = viewing_angle_for(x, y)
      next if angles.include?(angle)
      angles.push(angle)
    end
    angles
  end

  def visible_points(points)
    angles = valid_viewing_angles_for(points)
    max = 0
    angles.each do |viewing_angle|
      count = viewing_angle.visible?(points)
      max = count if count > max
    end
    max
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

  it 'returns 135' do
    expect(ViewingAngle.angle_for(-2, 2)).to eql(45.0 + 90.0)
  end

  it 'returns 135' do
    expect(ViewingAngle.angle_for(-5, 0)).to eql(180.0)
  end
end
