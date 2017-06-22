<<-DOC
You are given a single linked list, and you are asked to determine if there is a circle inside it
A circle means, a -> b -> c -> b, then it is a circle

Part 2.
Could you get the length of the circle for the input single linked list if there is one, 
or output 0 if there is no circle? (O(1) space and O(n) time complexity)

A -> B -> C -> D -> E -> F -> D
|T|H|
|A|B|
|B|D|
|C|F|
|D|E|
|E|D|


DOC
require 'spec_helper'
describe "cycle" do


  def circle?(head)
    return false if head.nil?

    tortoise, hare = head, head.next_item

    until hare.nil?
      return true if tortoise == hare
      tortoise, hare = tortoise.next_item, hare.next_item&.next_item
    end

    false
  end

  def cycle_length(head)
    return 0 if head.nil?

    tortoise, hare = head, head.next_item

    detected = false
    count = 0

    until hare.nil?
      if tortoise == hare
        return count if detected
        detected = true
      end
      count += 1 if detected
      tortoise, hare = tortoise.next_item, hare.next_item&.next_item
    end
    0
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

  it do
    a = Node.new("A")
    b = Node.new("B")
    c = Node.new("C")

    a.add(b)
    b.add(c)
    c.add(b)
    expect(circle?(a)).to be_truthy
    expect(cycle_length(a)).to eql(2)
  end


  <<-DOC
A -> B -> C -> D -> E -> F -> D

|T|H|
|A|B|
|B|D|
|C|F|
|D|E|
|E|D|
  DOC

  it do
    a = Node.new("A")
    b = Node.new("B")
    c = Node.new("C")
    d = Node.new("D")
    e = Node.new("E")
    f = Node.new("F")

    a.add(b)
    b.add(c)
    c.add(b)
    d.add(e)
    e.add(f)
    f.add(d)

    expect(cycle_length(a)).to eql(3)
  end
end
