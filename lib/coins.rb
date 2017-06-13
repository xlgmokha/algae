require 'pp'
# https://www.topcoder.com/community/data-science/data-science-tutorials/dynamic-programming-from-novice-to-advanced/#!

def coins(values, sum)
  min = Array.new(sum + 1, Float::INFINITY)
  min[0] = 0

  for i in (0..sum)
    for j in (0..(values.size - 1))
      break if values[j] > i
      coin = values[j]

      if min[i - coin] + 1 < min[i]
        min[i] = min[i - coin] + 1
      end
    end
  end
  min.last
end

PP.pp coins([1, 3, 5], 11)
