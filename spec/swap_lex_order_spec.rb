<<-DOC
Given a string str and array of pairs that indicates which indices in the string can be swapped, 
return the lexicographically largest string that results from doing the allowed swaps.
You can swap indices any number of times.

Example

For str = "abdc" and pairs = [[1, 4], [3, 4]], the output should be
swapLexOrder(str, pairs) = "dbca".

By swapping the given indices, you get the strings: 
"cbda", "cbad", "dbac", "dbca". 
The lexicographically largest string in this list is "dbca".

Input/Output

[time limit] 4000ms (rb)
[input] string str

A string consisting only of lowercase English letters.

Guaranteed constraints:
1 ≤ str.length ≤ 104.

[input] array.array.integer pairs

An array containing pairs of indices that can be swapped in str (1-based). This means that for each pairs[i], you can swap elements in str that have the indices pairs[i][0] and pairs[i][1].

Guaranteed constraints:
0 ≤ pairs.length ≤ 5000,
pairs[i].length = 2.

[output] string
DOC

describe "swap_lex_order" do
  def swap_lex_order(string, pairs)
    queue = [string]
    max_node = string
    computed_max = string.chars.sort.reverse.join

    visited = {}
    until queue.empty?
      node = queue.shift
      next if visited.key?(node)
      return node if node == computed_max

      if (node <=> max_node) > 0
        max_node = node
      end
      visited[node] = true

      pairs.each do |pair|
        x, y = node[pair[0] - 1], node[pair[1] - 1]
        duplicate = node.dup
        duplicate[pair[1] - 1] = x
        duplicate[pair[0] - 1] = y
        queue.push(duplicate) unless visited.key?(duplicate)
      end
    end
    max_node
  end

  def connected?(x, y)
    (x & y).size > 0
  end

  def union(x, y)
    (x + y)
  end

  def connected_components_in(pairs)
    connections = []
    connections.push(pairs.pop) if pairs.size > 0

    until pairs.empty?
      pair = pairs.pop
      connected = false
      connected_at = nil
      connections.size.times do |n|
        connection = connections[n]
        if connected?(pair, connection)
          if connected
            connections[connected_at] = union(connections[connected_at], connection)
            connections[connected_at] = union(connections[connected_at], pair)
            connections[n].clear
          else
            connections[n] = union(pair, connection)
            connected = true
            connected_at = n
          end
        end
      end
      connections.push(pair) unless connected
    end
    connections.find_all(&:any?).map(&:uniq).map(&:sort).sort { |x, y| (x[0] <=> y[0]) }
  end

  def swap_lex_order(string, pairs)
    connections = connected_components_in(pairs)
    result = string.dup
    connections.each do |connection|
      connection.sort!
      letters = connection.map { |x| string[x - 1] }.sort { |x, y| y <=> x }
      connection.each { |index| result[index - 1] = letters.shift }
    end
    result
  end

  [
    { pairs: [[1, 4], [3, 4]], expected: [[1, 3, 4]] },
    { pairs: [[1, 4], [7, 8]], expected: [[1, 4], [7, 8]] },
    { pairs: [[1, 3], [6, 8], [3, 8], [2, 7]], expected: [[1, 3, 6, 8], [2, 7]] },
    { pairs: [], expected: [] },
    { pairs: [[1,2], [3,4], [6,5], [8,10]], expected: [[1, 2], [3, 4], [5, 6], [8, 10]] },
    { pairs: [[8,5], [10,8], [4,18], [20,12], [5,2], [17,2], [13,25], [29,12], [22,2], [17,11]], expected: [[2, 5, 8, 10, 11, 17, 22], [4, 18], [12, 20, 29], [13, 25]]
  },
  ].each do |x|
    it do
      expect(connected_components_in(x[:pairs])).to eql(x[:expected])
    end
  end

  [
    { str: "abdc", pairs: [[1,4], [3,4]], expected: "dbca" },
    { str: "abcdefgh", pairs: [[1,4], [7,8]], expected: "dbcaefhg" },
    { str: "acxrabdz", pairs: [[1,3], [6,8], [3,8], [2,7]], expected: "zdxrabca" },
    { str: "z", pairs: [], expected: "z" },
    { str: "dznsxamwoj", pairs: [[1,2], [3,4], [6,5], [8,10]], expected:"zdsnxamwoj" },
    { str: "fixmfbhyutghwbyezkveyameoamqoi", pairs: [[8,5], [10,8], [4,18], [20,12], [5,2], [17,2], [13,25], [29,12], [22,2], [17,11]], expected: "fzxmybhtuigowbyefkvhyameoamqei" },
    { str: "lvvyfrbhgiyexoirhunnuejzhesylojwbyatfkrv", pairs: [[13,23], [13,28], [15,20], [24,29], [6,7], [3,4], [21,30], [2,13], [12,15], [19,23], [10,19], [13,14], [6,16], [17,25], [6,21], [17,26], [5,6], [12,24]], expected: "lyyvurrhgxyzvonohunlfejihesiebjwbyatfkrv" },
    { str: "a", pairs: [], expected: "a" },
  ].each do |x|
    it do
      result = with_profiler do
        swap_lex_order(x[:str], x[:pairs])
      end
      expect(result).to eql(x[:expected])
    end
  end
end
