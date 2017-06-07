require 'pp'

def lcs(s: , t: )
  #matrix = [ [0] * (t.size + 1) ] * (s.size + 1)
  matrix = Array.new(s.size + 1) { Array.new(t.size + 1, 0) }

  (s.size - 1).downto(0) do |i|
    (t.size - 1).downto(0) do |j|
      if s[i] == t[j]
        matrix[i][j] = 1 + matrix[i+1][j+1]
      else
        matrix[i][j] = [matrix[i][j+1], matrix[i+1][j]].max
      end
    end
  end
  # backtracking from 0, 0. follow the matches
  result = ""
  i, j = 0, 0
  until matrix[i][j] <= 0
    if s[i] == t[j]
      result << s[i]
      i += 1
      j += 1
    else
      if matrix[i][j + 1] > matrix[i + 1][j]
        j+=1
      else
        i+=1
      end
    end
  end
  result
end

PP.pp lcs(s: "GGCACCACG", t: "ACGGCGGATACG")
