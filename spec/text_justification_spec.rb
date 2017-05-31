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
    line_length = length
    until words.empty?
      word = words.shift
      if (line_length - word.size) > 1
        line.push(word)
        line_length -= word.size
      else
        words.unshift(word)
        break
      end
    end
    [line_length, line]
  end

  def pad(words, spaces)
    if words.size == 1
      return words.join + (" " * spaces)
    end
    until spaces <= 0
      (words.size - 1).times do |n|
        break if spaces <= 0
        words[n] << " "
        spaces -= 1
      end
    end
    words.join
  end

  def text_justification(words, length)
    lines = []

    until words.empty?
      spaces, line = next_line(words, length)
      line = pad(line, spaces)
      lines.push(line)
    end

    lines
  end

  it do
    words = ["This", "is", "an", "example", "of", "text", "justification."]
    l = 16
    expect(text_justification(words, l)).to contain_exactly(
      "This    is    an",
      "example  of text",
      "justification.  "
    )
  end
end
