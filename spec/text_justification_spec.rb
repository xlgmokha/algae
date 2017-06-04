<<-DOC
Given an array of words and a length l, format the text such that each line has exactly l characters 
and is fully justified on both the left and the right.
Words should be packed in a greedy approach; that is,
pack as many words as possible in each line.
Add extra spaces when necessary so that each line has exactly l characters.

Extra spaces between words should be distributed as evenly as possible. 
If the number of spaces on a line does not divide evenly between words, 
the empty slots on the left will be assigned more spaces than the slots on the right. 
For the last line of text and lines with one word only, 
the words should be left justified with no extra space inserted between them.

Example

For
words = ["This", "is", "an", "example", "of", "text", "justification."]
and l = 16, the output should be

textJustification(words, l) = ["This    is    an",
                               "example  of text",
                               "justification.  "]
Input/Output

[time limit] 4000ms (rb)
[input] array.string words

An array of words. Each word is guaranteed not to exceed l in length.

Guaranteed constraints:
1 ≤ words.length ≤ 150,
0 ≤ words[i].length ≤ l.

[input] integer l

The length that all the lines in the output array should be.

Guaranteed constraints:
1 ≤ l ≤ 60.

[output] array.string

The formatted text as an array containing lines of text, with each line having a length of l.
DOC
describe "text_justification" do
  def next_line(words, length)
    line = []
    line_length = 0

    until words.empty?
      word = words.shift
      required_spaces = line.size
      if line_length + word.size + required_spaces <= length
        line.push(word)
        line_length += word.size
      else
        words.unshift(word)
        break
      end
    end
    [length - line_length, line]
  end

  def pad_right(words, spaces)
    return words.join(' ') if spaces == 0

    before_spaces = words.map(&:size).inject(0, :+)
    words_with_spaces = words.join(' ')
    after_spaces = words_with_spaces.size
    added_spaces = after_spaces - before_spaces
    words_with_spaces + (" " * (spaces - added_spaces))
  end

  def pad_center(words, spaces)
    until spaces <= 0
      (words.size - 1).times do |n|
        words[n] << " "
        spaces -= 1
        break if spaces == 0
      end
    end
    words.join
  end

  def text_justification(words, length)
    lines = []
    until words.empty?
      spaces, line = next_line(words, length)
      right = words.empty? || line.size == 1
      lines.push(right ? pad_right(line, spaces) : pad_center(line, spaces))
    end
    lines
  end

  [
    { words: ["This", "is", "an", "example", "of", "text", "justification."], l: 16, expected: ["This    is    an", "example  of text", "justification.  "]},
    { words: ["Two", "words."], l: 11, expected: ["Two words. "] },
    { words: ["Two", "words."], l: 10, expected: ["Two words."] },
    { words: ["Two", "words."], l: 9, expected: ["Two      ", "words.   "] },
    { words: ["Looks", "like", "it", "can", "be", "a", "tricky", "test"], l: 25, expected: ["Looks  like  it  can be a", "tricky test              "] },
    { words: ["a", "b", "b", "longword"], l: 8, expected: ["a   b  b", "longword"] },
    { words: ["vba", "gaff", "ye", "gs", "cthj", "hf", "vetjj", "jm", "k", "f", "cgbf", "zzz"], l: 8, expected: ["vba gaff", "ye    gs", "cthj  hf", "vetjj jm", "k f cgbf", "zzz     "] },
    { words: ["Given", "an", "array", "of", "words", "and", "a", "length"], l: 9, expected: ["Given  an", "array  of", "words and", "a length "] },
    { words: ["Extra", "spaces", "between", "words", "should", "be", "distributed", "as", "evenly", "as", "possible"], l: 20, expected: ["Extra spaces between", "words    should   be", "distributed       as", "evenly as possible  "] },
    { words: [""], l: 2, expected: ["  "] },
    { words: ["a"], l: 1, expected: ["a"] },
    { words: ["a"], l: 2, expected: ["a "] },
    { words: ["a", "b", "c", "d", "e"], l: 1, expected: ["a", "b", "c", "d", "e"] },
    { words: ["a", "b", "c", "d", "e"], l: 3, expected: ["a b", "c d", "e  "] },
  ].each do |x|
    it do
      result = text_justification(x[:words], x[:l])
      expect(result).to contain_exactly(*x[:expected])
    end
  end
end
