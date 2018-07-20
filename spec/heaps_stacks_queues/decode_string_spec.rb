<<-DOC
Given an encoded string, return its corresponding decoded string.

The encoding rule is: k[encoded_string],
where the encoded_string inside the square brackets is repeated exactly k times. 
Note: k is guaranteed to be a positive integer.

Note that your solution should have linear complexity because this is what you will be asked during an interview.

Example

For s = "4[ab]", the output should be

decodeString(s) = "abababab";

For s = "2[b3[a]]", the output should be

decodeString(s) = "baaabaaa";

For s = "z1[y]zzz2[abc]", the output should be

decodeString(s) = "zyzzzabcabc".

Input/Output

[time limit] 4000ms (rb)
[input] string s

A string encoded as described above. It is guaranteed that:

the string consists only of digits, square brackets and lowercase English letters;
the square brackets form a regular bracket sequence;
all digits that appear in the string represent the number of times the content in the brackets that follow them repeats, i.e. k in the description above;
there are at most 20 pairs of square brackets in the given string.
Guaranteed constraints:

0 ≤ s.length ≤ 80.

[output] string
DOC

describe "#decode_string" do
  REGEX = /^(\D)?(\d)\[(.*)\]$/

  def decode(count, message)
    if REGEX.match?(message)
      x, y, z = message.scan(REGEX)[0]
      "#{x}#{decode(y.to_i, z)}" * count
    else
      message * count
    end
  end

  def decode_string(message)
    _, x, y = message.scan(REGEX)[0]
    decode(x.to_i, y)
  end

  def decode_string(message)
    head = 0
    number = []
    collect = false

    until head == message.length
      character = message[head]
      if character.match?(/\d/)
        number.push(character)
      else
        if collect
        else
          number = number.join.to_i
          if character == '['
            collect = true
          elsif character == ']'
            collect = false
          end
        end
      end
      head += 1
    end
  end

  def decode_string(message)
    return message unless message.match?(/\[|\]/)

    full = message.split("[", 2)
    left = full[0]
    middle = full[1][0...-1]
    right = full[1][-1]

    puts [left, middle, right].inspect
    puts decode_string(middle)

    middle * left.to_i
  end

  def decode_string(message)
    n = 0
    string = ""
    numbers = []
    strings = []
    message.chars.each do |char|
      if char.match?(/\d/)
        n = (n * 10) + char.to_i
      elsif char == '['
        numbers.push(n)
        n = 0
        strings.push(string) unless string == ""
        string = ""
      elsif char == ']'
        x = string * numbers.pop
        puts x
        #strings[-1] = x
        string = strings.pop
      else
        string += char
      end
    end
    puts string
    puts numbers.inspect
    puts strings.inspect
    nil
  end

  def digit?(x)
    x.match?(/\d/)
  end

  def unwind(stack)
    until stack.empty?
      y = stack.pop
      x = stack.pop
      result =  y * x rescue x + y
      stack.push(result)
      break if stack.size == 1
    end
    stack[0]
  end

  def decode_string(message)
    s, c, n = [], "", 0
    message.chars.each do |x|
      if digit?(x)
        s.push(c) unless c == ''
        c = ""
        n = (n * 10) + x.to_i
      elsif x == '['
        s.push(n)
        n = 0
      elsif x == ']'
        s.push(c) unless c == ''
        c = ""
      else
        c += x
      end
    end
    unwind(s)
  end

  [
    { s: "4[ab]", x: "abababab" },
    { s: "2[b3[a]]", x: "baaabaaa" },
    { s: "z1[y]zzz2[abc]", x: "zyzzzabcabc" },
    #{ s: "3[a]2[bc]", x: "aaabcbc" },
    #{ s: "3[a2[c]]", x: "accaccacc" },
    #{ s: "2[abc]3[cd]ef", x: "abcabccdcdcdef" },
    #{ s: "", x: nil },
    #{ s: "codefights", x: "codefights" },
    #{ s: "2[codefights]", x: "codefightscodefights" },
    #{ s: "100[codefights]", x: "codefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefights" },
    #{ s: "sd2[f2[e]g]i", x: "sdfeegfeegi" },
    #{ s: "2[a]", x: "aa" },
    #{ s: "2[a]3[b]4[c]5[d]", x: "aabbbccccddddd" },
    #{ s: "2[2[b]]", x: "bbbb" },
    #{ s: "2[2[2[b]]]", x: "bbbbbbbb" },
    #{ s: "2[2[2[2[b]]]]", x: "bbbbbbbbbbbbbbbb" },
  ].each do |x|
    it do
      expect(decode_string(x[:s])).to eql(x[:x])
    end
  end
end
