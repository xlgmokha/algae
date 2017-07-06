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

Part 3.
could you find the entry point of the circle?
which means the point A for (a->b->c->a)
DOC

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

  def cycle_length(head)
    return 0 if head.nil?

    tortoise, hare = head, head
    d1, d2 = 0, 0

    while hare && tortoise
      break if tortoise == hare && hare != head

      tortoise, hare = tortoise.next_item, hare.next_item&.next_item
      d1 += 1
      d2 += 2
    end
    return 0 if hare.nil?

    d2 - d1
  end

  def entry_point(head)
    return nil if head.nil?

    tortoise, hare = head, head.next_item

    until hare.nil?
      break if tortoise == hare
      tortoise, hare = tortoise.next_item, hare.next_item&.next_item
    end

    tortoise = head
    until hare == tortoise
      tortoise = tortoise.next_item
      hare = hare.next_item
    end
    return tortoise
  end

  def entry_point(head)
    return nil if head.nil?

    tortoise, hare = head, head.next_item

    until hare.nil?
      break if tortoise == hare
      tortoise, hare = tortoise.next_item, hare.next_item&.next_item
    end

    return nil if tortoise.nil? || hare.nil?

    visited = {}
    tortoise = head
    until hare == tortoise
      tortoise = tortoise.next_item
      hare = hare.next_item
      return hare if visited[hare]

      visited[hare] = true
    end
    return tortoise
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
    c.add(d)
    d.add(e)
    e.add(f)
    f.add(d)

    expect(circle?(a)).to be_truthy
    expect(cycle_length(a)).to eql(3)
  end

  it do
    a = Node.new("A")
    b = Node.new("B")

    a.add(b)

    expect(circle?(a)).to be_falsey
    expect(cycle_length(a)).to eql(0)
  end

  it 'detects the entry point' do
    # (a->b->c->a)
    # a|b
    # b|a
    # c|c
    a = Node.new("A")
    b = Node.new("B")
    c = Node.new("C")
    a.add(b)
    b.add(c)
    c.add(a)

    expect(entry_point(a)).to eql(a)
  end


  it 'detects entry point' do
    # A -> B -> C -> D -> C is C the entry point
    a = Node.new("A")
    b = Node.new("B")
    c = Node.new("C")
    d = Node.new("D")
    a.add(b)
    b.add(c)
    c.add(d)
    d.add(c)

    expect(entry_point(a)).to eql(c)
  end

  it 'finds no entry point' do
    #(a->b->c)
    a = Node.new("A")
    b = Node.new("B")
    c = Node.new("C")
    a.add(b)
    b.add(c)

    expect(entry_point(a)).to be_nil
  end
end
