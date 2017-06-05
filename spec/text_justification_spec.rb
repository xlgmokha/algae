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
    return pad_right(words, spaces) if words.size == 1

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

  def compute_cost(words, length)
    cost_matrix = [words.size]
    num_words = words.size
    0.upto(num_words - 1) do |i|
      cost_matrix[i] = [words.size]
      (i).upto(num_words - 1) do |j|
        candidates = words[i..j]
        cost = length - (candidates.sum(&:size) + candidates.size - 1)
        cost = cost >= 0 ? cost = cost ** 2 : Float::INFINITY
        cost_matrix[i][j] = cost
      end
    end
    cost_matrix
  end

  def dp_text_justification(words, length)
    cost_matrix = compute_cost(words, length)
    min_cost = []
    final_result = []
    i = j = words.size - 1
    while i > -1
      cost = cost_matrix[i][j]
      if Float::INFINITY == cost
        # check at what point we split it.
        0.upto(j) do |jj|
          next unless cost_matrix[i][j - jj]
          next unless min_cost[j - jj + 1]
          next_cost = cost_matrix[i][j - jj] + min_cost[j - jj + 1]
          if next_cost < cost
            cost = next_cost
            min_cost[i] = cost
            final_result[i] = j - jj + 1
          end
        end
        j = words.size - 1
      else
        min_cost[i] = cost
        final_result[i] = words.size
      end
      i -= 1
    end

    lines = []
    n = 0
    index = 0
    loop do
      take = final_result[n] - index
      lines[index] = []
      take.times do
        lines[index] << words.shift
      end
      if words.empty?
        lines[index] = pad_right(lines[index].compact, length - lines[index].compact.sum(&:size))
      else
        lines[index] = pad_center(lines[index].compact, length - lines[index].compact.sum(&:size))
      end
      n = final_result[n]
      index += 1
      break if words.empty?
    end
    lines
  end

  [
    { words: ["Tushar", "Roy", "likes", "to", "code"], l: 10, expected: ["Tushar    ", "Roy  likes", "to code   "] },
  ].each do |x|
    it do
      result = dp_text_justification(x[:words], x[:l])
      expect(result).to contain_exactly(*x[:expected])
    end
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
