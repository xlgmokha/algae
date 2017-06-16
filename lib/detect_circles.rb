<<-DOC
[2:10 PM] Marvin Liu: You are given a single linked list, and you are asked to determine if there is a circle inside it
[2:11 PM] Marvin Liu: A circle means, a -> b -> c -> b, then it is a circle
DOC

def circle?(head)
  true
end

class Node
  attr_reader :next_item, :value

  def initialize(value)
    @value
  end

  def add(value)
    @next_item = value.is_a?(Node) ? value : Node.new(value)
  end
end

a = Node.new("A")
b = Node.new("B")
c = Node.new("C")

a.add(b)
b.add(c)
c.add(b)

raise 'heck' unless circle?(a)
