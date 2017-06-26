<<-DOC
Note: Write a solution that only iterates over the string once and uses O(1) additional memory, 
since this is what you would be asked to do during a real interview.

Given a string s, find and return the first instance of a non-repeating character in it.
If there is no such character, return '_'.

Example

For s = "abacabad", the output should be
firstNotRepeatingCharacter(s) = 'c'.

There are 2 non-repeating characters in the string: 'c' and 'd'. 
Return c since it appears in the string first.

For s = "abacabaabacaba", the output should be
firstNotRepeatingCharacter(s) = '_'.

There are no characters in this string that do not repeat.

Input/Output

[time limit] 4000ms (rb)
[input] string s

A string that contains only lowercase English letters.

Guaranteed constraints:
1 ≤ s.length ≤ 105.

[output] char

The first non-repeating character in s, or '_' if there are no characters that do not repeat.
DOC

describe "first_non_repeating_character" do
  def first_non_repeating_character(message)
    chars = message.chars
    hash = chars.inject(Hash.new(0)) { |memo, char| memo[char] += 1; memo }
    chars.each do |char|
      if hash[char] <= 1
        return char
      end
    end
    "_"
  end

  [
    { s: "abacabad", x: "c" },
    { s: "abacabaabacaba", x: "_" },
    { s: "z", x: "z" },
    { s: "bcb", x: "c" },
    { s: "bcccccccb", x: "_" },
    { s: "abcdefghijklmnopqrstuvwxyziflskecznslkjfabe", x: "d" },
    { s: "zzz", x: "_" },
    { s: "bcccccccccccccyb", x: "y" },
    { s: "xdnxxlvupzuwgigeqjggosgljuhliybkjpibyatofcjbfxwtalc", x: "d" },
    { s: "ngrhhqbhnsipkcoqjyviikvxbxyphsnjpdxkhtadltsuxbfbrkof", x: "g" },
  ].each do |x|
    it do
      expect(first_non_repeating_character(x[:s])).to eql(x[:x])
    end
  end
end
