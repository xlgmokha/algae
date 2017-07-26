<<-DOC
You have a collection of coins, and you know the values of the coins and the quantity of each type of coin in it.
You want to know how many distinct sums you can make from non-empty groupings of these coins.

Example

For coins = [10, 50, 100] and quantity = [1, 2, 1], the output should be
possibleSums(coins, quantity) = 9.

Here are all the possible sums:

50 = 50;
10 + 50 = 60;
50 + 100 = 150;
10 + 50 + 100 = 160;
50 + 50 = 100;
10 + 50 + 50 = 110;
50 + 50 + 100 = 200;
10 + 50 + 50 + 100 = 210;
10 = 10;
100 = 100;
10 + 100 = 110.
As you can see, there are 9 distinct sums that can be created from non-empty groupings of your coins.

Input/Output

[time limit] 4000ms (rb)
[input] array.integer coins

An array containing the values of the coins in your collection.

Guaranteed constraints:
1 ≤ coins.length ≤ 20,
1 ≤ coins[i] ≤ 104.

[input] array.integer quantity

An array containing the quantity of each type of coin in your collection. quantity[i] indicates the number of coins that have a value of coins[i].

Guaranteed constraints:
quantity.length = coins.length,
1 ≤ quantity[i] ≤ 105.

It is guaranteed that (quantity[0] + 1) * (quantity[1] + 1) * ... * (quantity[quantity.length - 1] + 1) <= 106.

[output] integer

The number of different possible sums that can be created from non-empty groupings of your coins.
DOC

describe "#possible_sums" do
  def possible_sums(coins, quantity)
    maximum = coins.zip(quantity).map { |(x, y)| x * y }.sum

    dp = [false] * (maximum + 1)
    dp[0] = true

    coins.zip(quantity).each do |(coin, q)|
      (0...coin).each do |b|
        num = -1
        (b..maximum + 1).step(coin).each do |i|
          if dp[i]
            num = 0
          elsif num >= 0
            num += 1
          end
          dp[i] = (0 <= num && num <= q)
        end
      end
    end
    dp.map { |x| x ? 1 : 0 }.sum - 1
  end

  [
    { coins: [10, 50, 100], quantity: [1, 2, 1], x: 9 },
    { coins: [10, 50, 100, 500], quantity: [5, 3, 2, 2], x: 122 },
    { coins: [1], quantity: [5], x: 5 },
    { coins: [1, 1], quantity: [2, 3], x: 5 },
    { coins: [1, 2], quantity: [50000, 2], x: 50004 },
    { coins: [1, 2, 3], quantity: [2, 3, 10000], x: 30008 },
    { coins: [3, 1, 1], quantity: [111, 84, 104], x: 521 },
    { coins: [1, 1, 1, 1, 1], quantity: [9, 19, 18, 12, 19], x: 77 },
  ].each do |x|
    it do
      expect(possible_sums(x[:coins], x[:quantity])).to eql(x[:x])
    end
  end
end
