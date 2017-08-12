<<-DOC
You have two arrays of strings, words and parts.
Return an array that contains the strings from words,
modified so that any occurrences of the substrings from parts are surrounded by square brackets [],
following these guidelines:

If several parts substrings occur in one string in words, choose the longest one.
If there is still more than one such part, then choose the one that appears first in the string.

Example

For words = ["Apple", "Melon", "Orange", "Watermelon"] and parts = ["a", "mel", "lon", "el", "An"], the output should be
findSubstrings(words, parts) = ["Apple", "Me[lon]", "Or[a]nge", "Water[mel]on"].

While "Watermelon" contains three substrings from the parts array, "a", "mel", and "lon", "mel" is the longest substring
that appears first in the string.

Input/Output

[time limit] 4000ms (rb)
[input] array.string words

An array of strings consisting only of uppercase and lowercase English letters.

Guaranteed constraints:
0 ≤ words.length ≤ 104,
1 ≤ words[i].length ≤ 30.

[input] array.string parts

An array of strings consisting only of uppercase and lower English letters.
Each string is no more than 5 characters in length.

Guaranteed constraints:
0 ≤ parts.length ≤ 105,
1 ≤ parts[i].length ≤ 5,
parts[i] ≠ parts[j].

[output] array.string
DOC

describe "#find_substrings" do
  #def find_substrings(words, parts)
    #regex = /(#{parts.join("|")})/

    #puts regex.inspect
    #words.map do |word|
      #if match = word.match(regex)
        #max = match.captures.max { |a, b| a.length <=> b.length }
        #puts [word, match.captures, max].inspect
        #word.gsub(max, "[#{max}]")
      #else
        #word
      #end
    #end
  #end

  def find_substrings(words, parts)
    parts = parts.sort { |x, y| y.length <=> x.length }
    words.map do |word|
      current = nil
      length = nil
      index = nil
      parts.each do |part|
        next if length && length > part.size

        if next_index = word.index(part)
          if current.nil? || part.length > length || (part.length == length && next_index < index)
            current = part
            length = part.length
            index = next_index
          end
        end
      end
      current ? word.sub(current, "[#{current}]") : word
    end
  end

  <<-DOC
  Apple
  [0,1,2,3,4]
  [1,2,3,4,5]
  [A,p,p,l,e]
root of the tree (A): array position 1
root's left child (B): array position 2
root's right child (C): array position 3
...
left child of node in array position K: array position 2K
right child of node in array position K: array position 2K+1

    A
   / \
  p   p
 /\
l  e

  DOC
  #def to_tree(string)
    #string.chars.each_with_index do |char, index|
    #end
  #end

  #def to_sexpression(tree, root)
    #return "()" if tree[root-1].nil?
    #"(#{tree[root-1]}#{to_sexpression(tree, 2*root)},#{to_sexpression(tree, 2*root + 1)})"
  #end

  #def find_substrings(words, parts)
    #words.map do |word|
      #word_x = to_sexpression(word.chars, 1)
      #result = nil
      #parts.each do |part|
        #part_x = to_sexpression(part.chars, 1)
        #result = word.sub(part, "[#{part}]") if word_x.include?(part_x)
      #end
      #result
    #end
  #end

  #def find_substrings(words, parts)
    #words.each do |word|
      #parts.each do |parts|

      #end
    #end
  #end

  [
    { words: ["Apple", "Melon", "Orange", "Watermelon"], parts: ["a", "mel", "lon", "el", "An"], x: ["Apple", "Me[lon]", "Or[a]nge", "Water[mel]on"] },
    { words: ["Aaaaaaaaa", "bcdEFGh"], parts: ["aaaaa", "Aaaa", "E", "z", "Zzzzz"], x: ["A[aaaaa]aaa", "bcd[E]FGh"] },
    { words: [], parts: ["aaaaa", "Aaaa", "E", "z", "Zzzzz", "a", "mel", "lon", "el", "An"], x: [] },
    { words: ["Aaaaaaaaa", "bcdEFGh", "Apple", "Melon", "Orange", "Watermelon"], parts: [], x: ["Aaaaaaaaa", "bcdEFGh", "Apple", "Melon", "Orange", "Watermelon"] },
    { words: ["neuroses", "myopic", "sufficient", "televise", "coccidiosis", "gules", "during", "construe", "establish", "ethyl"], parts: ["aaaaa", "Aaaa", "E", "z", "Zzzzz", "a", "mel", "lon", "el", "An", "ise", "d", "g", "wnoVV", "i", "IUMc", "P", "KQ", "QfRz", "Xyj", "yiHS"], x: ["neuroses", "myop[i]c", "suff[i]cient", "telev[ise]", "cocc[i]diosis", "[g]ules", "[d]uring", "construe", "est[a]blish", "ethyl"] },
    { words: ["abc"], parts: ["abc"], x: ["[abc]"] },
    { words: ["abc"], parts: ["ABC"], x: ["abc"] },
    { words: ["a", "b"], parts: ["b"], x: ["a", "[b]"] },
    { words: ["aaaaaaaaaaaaaaaaaaaaaaaaaaaaab", "aaaaaaaaaaaaaaaaaaaaaaaaaaaaab", "aaaaaaaaaaaaaaaaaaaaaaaaaaaaab", "aaaaaaaaaaaaaaaaaaaaaaaaaaaaab", "aaaaaaaaaaaaaaaaaaaaaaaaaaaaab", "aaaaaaaaaaaaaaaaaaaaaaaaaaaaa", "aaaaaaaaaaaaaaaaaaaaaaaaaaaaa", "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", "aaaaaaaaaaaaaaaaaaaaaaaaaaaaac"], parts: ["aaaaa", "bbbbb", "a", "aa", "aaaa", "AAAAA", "aaa", "aba", "aaaab", "c", "bbbb", "d", "g", "ccccc", "B", "C", "P", "D"], x: ["[aaaaa]aaaaaaaaaaaaaaaaaaaaaaaab", "[aaaaa]aaaaaaaaaaaaaaaaaaaaaaaab", "[aaaaa]aaaaaaaaaaaaaaaaaaaaaaaab", "[aaaaa]aaaaaaaaaaaaaaaaaaaaaaaab", "[aaaaa]aaaaaaaaaaaaaaaaaaaaaaaab", "[aaaaa]aaaaaaaaaaaaaaaaaaaaaaaa", "[aaaaa]aaaaaaaaaaaaaaaaaaaaaaaa", "[aaaaa]aaaaaaaaaaaaaaaaaaaaaaaaa", "[aaaaa]aaaaaaaaaaaaaaaaaaaaaaaaa", "[aaaaa]aaaaaaaaaaaaaaaaaaaaaaaac"] },
    { words: ["during"], parts: ["d", "g", "i"], x: ["[d]uring"] },
  ].each do |x|
    it do
      result = with_profiler do
        find_substrings(x[:words], x[:parts])
      end

      expect(result).to eql(x[:x])
    end
  end
end
