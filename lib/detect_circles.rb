<<-DOC
You are given a single linked list, and you are asked to determine if there is a circle inside it
A circle means, a -> b -> c -> b, then it is a circle
DOC
require 'byebug'

def circle?(list)
  tortoise, hare = list, list.next_item

  until hare.nil?
    return true if tortoise == hare
    tortoise = tortoise.next_item
    hare = hare.next_item.next_item
  end

  return false
end

class Node
  attr_reader :next_item, :value

  def initialize(value)
    @value = value
  end

  def add(value)
    @next_item = value.is_a?(Node) ? value : Node.new(value)
  end

  def inspect
    "#{object_id} #{value}"
  end
end

a = Node.new("A")
b = Node.new("B")
c = Node.new("C")

a.add(b)
b.add(c)
c.add(b)

raise 'heck' unless circle?(a)
