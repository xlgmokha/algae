<<-DOC
A top secret message containing uppercase letters from 'A' to 'Z' has been encoded as numbers using the following mapping:

'A' -> 1
'B' -> 2
...
'Z' -> 26
You are an FBI agent and you need to determine the total number of ways that the message can be decoded.

Since the answer could be very large, take it modulo 109 + 7.

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
  def map_decoding(message)
    0
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
