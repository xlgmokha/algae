<<-DOC
Given an array strings, determine whether it follows the sequence given in the patterns array.
In other words, there should be no i and j for which strings[i] = strings[j] and patterns[i] ≠ patterns[j]
or for which strings[i] ≠ strings[j] and patterns[i] = patterns[j].

Example

For strings = ["cat", "dog", "dog"] and patterns = ["a", "b", "b"], the output should be
areFollowingPatterns(strings, patterns) = true;
For strings = ["cat", "dog", "doggy"] and patterns = ["a", "b", "b"], the output should be
areFollowingPatterns(strings, patterns) = false.
Input/Output

[time limit] 4000ms (rb)
[input] array.string strings

An array of strings, each containing only lowercase English letters.

Guaranteed constraints:
1 ≤ strings.length ≤ 105,
1 ≤ strings[i].length ≤ 10.

[input] array.string patterns

An array of pattern strings, each containing only lowercase English letters.

Guaranteed constraints:
patterns.length = strings.length,
1 ≤ patterns[i].length ≤ 10.

[output] boolean

Return true if strings follows patterns and false otherwise.
DOC

describe "are_following_patterns" do
  <<-THINK
  { cat: :a, dog: :b } X
  { a: :cat, b: :dog } X
  { a: [0], b: [1, 2] } X
  { a: [cat], b: [nil, dog, doggy]
  THINK
  def following_patterns?(strings, patterns)
    return false if strings.size != patterns.size
    items = Hash.new { |hash, key| hash[key] = [] }

    patterns.each_with_index do |pattern, index|
      items[pattern][index] = strings[index]
    end

    true
  end

  def following_patterns?(strings, patterns)
    return false if strings.size != patterns.size
    x_s, x_p = Hash.new { |h, k| h[k] = [] }, Hash.new { |h, k| h[k] = [] }

    strings.each_with_index { |string, index| x_s[string].push(index) }
    patterns.each_with_index { |pattern, index| x_p[pattern].push(index) }

    return false if x_s.keys.size != x_p.keys.size
    strings.each_with_index do |string, index|
      return false if x_s[string] != x_p[patterns[index]]
    end

    patterns.each_with_index do |pattern, index|
      return false if x_p[pattern] != x_s[strings[index]]
    end
    true
  end

  def following_patterns?(strings, patterns)
    k, m = {}, {}
    i = 0
    a = strings.map { |string| k[string] ||= (i += 1) }
    i = 0
    b = patterns.map { |pattern| m[pattern] ||= (i += 1) }
    a == b
  end

  [
    { strings: ["cat", "dog", "dog"], patterns: ["a", "b", "b"], x: true },
    { strings: ["cat", "dog", "doggy"], patterns: ["a", "b", "b"], x: false },
    { strings: ["cat", "dog", "dog"], patterns: ["a", "b", "c"], x: false },
    { strings: ["aaa"], patterns: ["aaa"], x: true },
    { strings: ["aaa", "aaa", "aaa"], patterns: ["aaa", "bbb", "aaa"], x: false },
    { strings: ["aaa", "aab", "aaa"], patterns: ["aaa", "aaa", "aaa"], x: false },
    { strings: ["re", "jjinh", "rnz", "frok", "frok", "hxytef", "hxytef", "frok"], patterns: ["kzfzmjwe", "fgbugiomo", "ocui", "gafdrts", "gafdrts", "ebdva", "ebdva", "gafdrts"], x: true },
    { strings: ["kwtfpzm", "kwtfpzm", "kwtfpzm", "kwtfpzm", "kwtfpzm", "wfktjrdhu", "anx", "kwtfpzm"], patterns: ["z", "z", "z", "hhwdphhnc", "zejhegjlha", "xgxpvhprdd", "e", "u"], x: false },
    { strings: ["ato", "ato", "jflywws", "ato", "ato", "se", "se", "kiolm", "wizdkdqke"], patterns: ["ofnmiqelt", "ofnmiqelt", "flqmwoje", "ofnmiqelt", "zdohw", "jyk", "ujddjtxt", "s", "kw"], x: false },
    { strings: ["syf", "syf", "oxerkx", "oxerkx", "syf", "xgwatff", "pmnfaw", "t", "ajyvgwd", "xmhb", "ajg", "syf", "syf", "wjddgkopae", "fgrpstxd", "t", "i", "psw", "wjddgkopae", "wjddgkopae", "oxerkx", "zf", "jvdtdxbefr", "rbmphtrmo", "syf", "yssdddhyn", "syf", "jvdtdxbefr", "funnd", "syf", "syf", "wd", "syf", "vnntavj", "wjddgkopae", "yssdddhyn", "wcvk", "wjddgkopae", "fh", "zf", "gpkdcwf", "qkbw", "zf", "teppnr", "jvdtdxbefr", "fmn", "i", "hzmihfrmq", "wjddgkopae", "syf", "vnntavj", "dung", "kn", "qkxo", "ajyvgwd", "fs", "kanixyaepl", "syf", "tl", "yzhaa", "dung", "wa", "syf", "jtucivim", "tl", "kanixyaepl", "oxerkx", "wjddgkopae", "ey", "ai", "zf", "di", "oxerkx", "dung", "i", "oxerkx", "wmtqpwzgh", "t", "beascd", "me", "akklwhtpi", "nxl", "cnq", "bighexy", "ddhditvzdu", "funnd", "wmt", "dgx", "fs", "xmhb", "qtcxvdcl", "thbmn", "pkrisgmr", "mkcfscyb", "x", "oxerkx", "funnd", "iesr", "funnd", "t"], patterns: ["enrylabgky", "enrylabgky", "dqlqaihd", "dqlqaihd", "enrylabgky", "ramsnzhyr", "tkibsntkbr", "l", "bgtws", "xwuaep", "o", "enrylabgky", "enrylabgky", "e", "auljuhtj", "l", "d", "jfzokgt", "e", "e", "dqlqaihd", "fgglhiedk", "nj", "quhv", "enrylabgky", "oadats", "enrylabgky", "nj", "zwupro", "enrylabgky", "enrylabgky", "pyw", "enrylabgky", "bedpuycdp", "e", "oadats", "i", "e", "fobyfznrxm", "fgglhiedk", "irxtd", "oyvf", "fgglhiedk", "ebpp", "nj", "p", "d", "cufxylz", "e", "enrylabgky", "bedpuycdp", "mitzb", "shsnw", "papmvh", "bgtws", "chtp", "pze", "enrylabgky", "klp", "wpx", "mitzb", "fo", "enrylabgky", "bvcigrirhe", "klp", "pze", "dqlqaihd", "e", "iufunacwjo", "bubgww", "fgglhiedk", "og", "dqlqaihd", "mitzb", "d", "dqlqaihd", "mysidv", "l", "naj", "clftmrwl", "fjb", "zjjnrffb", "sh", "gcn", "ouispza", "zwupro", "c", "rdank", "chtp", "xwuaep", "jufhm", "iyntbgm", "sufs", "mkivpe", "bxdd", "dqlqaihd", "zwupro", "vzxbbculgv", "zwupro", "l"], x: true },
  ].each do |x|
    it do
      result = following_patterns?(x[:strings], x[:patterns])
      expect(result).to eql(x[:x])
    end
  end
end
