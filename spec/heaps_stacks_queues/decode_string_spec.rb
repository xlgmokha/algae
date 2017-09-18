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

  [
    { s: "4[ab]", x: "abababab" },
    { s: "2[b3[a]]", x: "baaabaaa" },
    { s: "z1[y]zzz2[abc]", x: "zyzzzabcabc" },
    { s: "3[a]2[bc]", x: "aaabcbc" },
    { s: "3[a2[c]]", x: "accaccacc" },
    { s: "2[abc]3[cd]ef", x: "abcabccdcdcdef" },
    { s: "", x: nil },
    { s: "codefights", x: "codefights" },
    { s: "2[codefights]", x: "codefightscodefights" },
    { s: "100[codefights]", x: "codefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefightscodefights" },
    { s: "sd2[f2[e]g]i", x: "sdfeegfeegi" },
    { s: "2[a]", x: "aa" },
    { s: "2[a]3[b]4[c]5[d]", x: "aabbbccccddddd" },
    { s: "2[2[b]]", x: "bbbb" },
    { s: "2[2[2[b]]]", x: "bbbbbbbb" },
    { s: "2[2[2[2[b]]]]", x: "bbbbbbbbbbbbbbbb" },
  ].each do |x|
    it do
      expect(decode_string(x[:s])).to eql(x[:x])
    end
  end
end
