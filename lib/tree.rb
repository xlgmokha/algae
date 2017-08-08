class Tree
  attr_accessor :value, :left, :right

  def initialize(value, left: nil, right: nil)
    @value = value
    @left = left
    @right = right
  end

  def to_a
    [value, left&.to_a, right&.to_a]
  end

  def print(prefix = '', tail = true)
    puts(prefix + (tail ? "└── " : "├── ") + value.to_s)

    prefix = prefix + (tail ? "    " : "│   ")
    right.print(prefix, false) if right
    left.print(prefix, false) if left
  end

  def to_h
    { value: value, left: left&.to_h, right: right&.to_h }
  end

  def self.build_from(hash)
    return nil if hash.nil?
    Tree.new(hash[:value], left: build_from(hash[:left]), right: build_from(hash[:right]))
  end
end
