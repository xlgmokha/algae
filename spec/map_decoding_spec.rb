<<-DOC
A top secret message containing uppercase letters from 'A' to 'Z' has been encoded as numbers using the following mapping:

'A' -> 1
'B' -> 2
...
'Z' -> 26
You are an FBI agent and you need to determine the total number of ways that the message can be decoded.

Since the answer could be very large, take it modulo 10^9 + 7.

Example

For message = "123", the output should be

mapDecoding(message) = 3.

"123" can be decoded as "ABC" (1 2 3), "LC" (12 3) or "AW" (1 23), so the total number of ways is 3.

Input/Output

[time limit] 4000ms (rb)
[input] string message

A string containing only digits.

Guaranteed constraints:

0 ≤ message.length ≤ 105.

[output] integer

The total number of ways to decode the given message.
DOC

describe "map_decoding" do
  <<-THINK
  "abc"

   |1|2|3|
  1|a|b|c|
  2|L|W|-|
  3|-|-|-|

  |1|2|3|
  |2|2|1|

  10122110
  10|12|21|10
  10|12|2|1|10
  10|1|22|1|10
  10|1|2|21|10
  10|1|2|2|1|10

  [1, 2, 3]

  [1], [2, 3]  [1, 2, 3]
  [2], [3]     [2], [3]
  [3]          [3]


  THINK
  def map_decoding(message)
    puts [message].inspect
    if message.size == 1
      return (0..26).include?(message[0].to_i - 1) ? 1 : 0
    end

    count = 0
    results = []
    (message.size - 1).downto(0) do |i|
      tail = message[i].to_i
      combined = message[i-1..i].to_i
      head = message[i - 1].to_i

      if tail == 0
        return 0 if combined < 0 || combined >= 26
        results.push(combined)
      else
        if head >= 0 && head < 26
          count += 1
          results << tail
        end
      end
      puts results.inspect

      i += 1
    end

    modulo = (10 ** 9) + 7
    count % modulo
  end

  def decode(chars, rest = [])
    #puts [chars, rest].inspect
    return chars if rest.empty?

    results = []
    first = rest[0]
    results.push(decode([first], rest[1..rest.size]))

    second = rest[1]
    results.push(decode([first + second], rest[2..rest.size])) if second
    results
  end

  def map_decoding(message)
    decode([], message.chars)
  end

  [
    { message: "123", expected: 3 },
    { message: "12", expected: 2 },
    { message: "0", expected: 0 },
    { message: "1", expected: 1 },
    { message: "11", expected: 2 },
    { message: "301", expected: 0 },
    { message: "1001", expected: 0 },
    { message: "10122110", expected: 5 },
    { message: "", expected: 1 },
    { message: "11115112112", expected: 104 },
    { message: "2871221111122261", expected: 233 },
    { message: "1221112111122221211221221212212212111221222212122221222112122212121212221212122221211112212212211211", expected: 782204094 },
  ].each do |x|
    it do
      expect(map_decoding(x[:message])).to eql(x[:expected])
    end
  end
end
