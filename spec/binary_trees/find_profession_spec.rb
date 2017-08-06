<<-DOC
Consider a special family of Engineers and Doctors. This family has the following rules:

Everybody has two children.
The first child of an Engineer is an Engineer and the second child is a Doctor.
The first child of a Doctor is a Doctor and the second child is an Engineer.
All generations of Doctors and Engineers start with an Engineer.
We can represent the situation using this diagram:

                E
           /         \
          E           D
        /   \        /  \
       E     D      D    E
      / \   / \    / \   / \
     E   D D   E  D   E E   D
Given the level and position of a person in the ancestor tree above, find the profession of the person.
Note: in this tree first child is considered as left child, second - as right.

Example

For level = 3 and pos = 3, the output should be
findProfession(level, pos) = "Doctor".

Input/Output

[time limit] 4000ms (rb)
[input] integer level

The level of a person in the ancestor tree, 1-based.

Guaranteed constraints:
1 ≤ level ≤ 30.

[input] integer pos

The position of a person in the given level of ancestor tree, 1-based, counting from left to right.

Guaranteed constraints:
1 ≤ pos ≤ 2(level - 1).

[output] string

Return Engineer or Doctor.
http://www.geeksforgeeks.org/find-profession-in-a-hypothetical-special-situation/
DOC

describe "#find_profession" do
  # [e]
  # [e,d]
  # [e,d,d,e]
  # [e,d,d,e,d,e,e,d]
  # [e,d,d,e,d,e,e,d,d,e,e,d,e,d,d,e]
  # [e,d,d,e,d,e,e,d,d,e,e,d,e,d,d,e,d,e,e,d,e,d,d,e,e,d,d,e,d,e,e,d]
  def find_profession(level, position)
    return :Engineer if level == 1

    parent_position = position.odd? ? (position + 1) / 2 : position / 2
    parent = find_profession(level - 1, parent_position)
    position.odd? ? parent : parent == :Doctor ? :Engineer : :Doctor
  end

  def bits_for(n)
    #count = 0
    #while n > 0
      #n &= n - 1
      #count += 1
    #end
    #count
    n.to_s(2).count('1')
  end

  # [1]
  # [1,0]
  # [1,0,0,1]
  # [1,0,0,1,0,1,1,0]
  # [1,0,0,1,0,1,1,0,0,1,1,0,1,0,0,1]
  # [1,0,0,1,0,1,1,0,0,1,1,0,1,0,0,1,0,1,1,0,1,0,0,1,1,0,0,1,0,1,1,0]
  def find_profession(level, position)
    bits_for(position - 1).odd? ? :Doctor : :Engineer
  end

  def find_profession(level, position)
    (position - 1).to_s(2).count('1').odd? ? :Doctor : :Engineer
  end

  [
    { level: 3, pos: 3, x: "Doctor" },
    { level: 4, pos: 2, x: "Doctor" },
    { level: 1, pos: 1, x: "Engineer" },
    { level: 8, pos: 100, x: "Engineer" },
    { level: 10, pos: 470, x: "Engineer" },
    { level: 17, pos: 5921, x: "Doctor" },
    { level: 20, pos: 171971, x: "Engineer" },
    { level: 25, pos: 16777216, x: "Engineer" },
    { level: 30, pos: 163126329, x: "Doctor" },
  ].each do |x|
    it do
      expect(find_profession(x[:level], x[:pos])).to eql(x[:x].to_sym)
    end
  end
end
