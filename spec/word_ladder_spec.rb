description =<<-DOC
Given two words, beginWord and endWord, and a wordList of approved words, find the length of the shortest transformation sequence from beginWord to endWord such that:

Only one letter can be changed at a time
Each transformed word must exist in the wordList.
Return the length of the shortest transformation sequence, or 0 if no such transformation sequence exists.

Note: beginWord does not count as a transformed word. You can assume that beginWord and endWord are not empty and are not the same.

Example

For beginWord = "hit", endWord = "cog", and wordList = ["hot", "dot", "dog", "lot", "log", "cog"], the output should be
wordLadder(beginWord, endWord, wordList) = 5.

The shortest transformation is "hit" -> "hot" -> "dot" -> "dog" -> "cog" with a length of 5.

Input/Output

[time limit] 4000ms (rb)
[input] string beginWord

Guaranteed constraints:
1 ≤ beginWord.length ≤ 5.

[input] string endWord

Guaranteed constraints:
endWord.length = beginWord.length.

[input] array.string wordList

An array containing all of the approved words. All words in the array are the same length and contain only lowercase English letters. You can assume that there are no duplicates in wordList.

Guaranteed constraints:
2 ≤ wordList.length ≤ 600,
wordList[i].length = beginWord.length.

[output] integer

An integer representing the length of the shortest transformation sequence from beginWord to endWord using only words from wordList as described above.
DOC

describe "word_ladder" do
  def match?(word, other, length: word.chars.size)
    (word.chars & other.chars).count == length - 1
  end

  def word_ladder(words, begin_word:, end_word:)
    puts [begin_word, end_word, words].inspect
    return 0 if words.empty?
    return 0 if begin_word == end_word

    words.each do |word|
      if begin_word == word
        remaining = words - [begin_word]
        return word_ladder(remaining, begin_word: word, end_word: end_word)
      end
      if match?(begin_word, word)
        remaining = words - [begin_word]
        return word_ladder(remaining, begin_word: word, end_word: end_word) + 1
      end
    end
    0
  end

  it do
    words = ["hot", "dot", "dog", "lot", "log", "cog"]
    expect(word_ladder(words, begin_word: "hit", end_word: "cog")).to eql(5)
  end

  it do
    expect(word_ladder(["a", "b", "c"], begin_word: "a", end_word: "c")).to eql(2)
  end

  it do
    expect(word_ladder(["hot", "dog"], begin_word: "hot", end_word: "dog")).to eql(0)
  end

  it do
    words = ["hot", "dog", "cog", "pot", "dot"]
    expect(word_ladder(words, begin_word: "hot", end_word: "dog")).to eql(3)
  end

  it do
    words = ["hot", "cog", "dot", "dog", "hit", "lot", "log"]
    expect(word_ladder(words, begin_word: "hit", end_word: "cog")).to eql(5)
  end

  it do
    words = ["most", "fist", "lost", "cost", "fish"]
    expect(word_ladder(words, begin_word: "lost", end_word: "cost")).to eql(2)
  end

  it do
    words = ["talk", "tons", "fall", "tail", "gale", "hall", "negs"]
    expect(word_ladder(words, begin_word: "talk", end_word: "tail")).to eql(0)
  end

  it do
    words = ["peale", "wilts", "place", "fetch", "purer", "pooch", "peace", "poach", "berra", "teach", "rheum", "peach"]
    expect(word_ladder(words, begin_word: "teach", end_word: "place")).to eql(4)
  end
end
