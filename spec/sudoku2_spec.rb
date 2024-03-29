<<-DOC
Sudoku is a number-placement puzzle.
The objective is to fill a 9 × 9 grid with numbers in such a way that each column, each row,
and each of the nine 3 × 3 sub-grids that compose the grid all contain all of the numbers from 1 to 9 one time.

Implement an algorithm that will check whether the given grid of numbers represents a valid
Sudoku puzzle according to the layout rules described above.
Note that the puzzle represented by grid does not have to be solvable.

Example

For

grid = [['.', '.', '.', '1', '4', '.', '.', '2', '.'],
        ['.', '.', '6', '.', '.', '.', '.', '.', '.'],
        ['.', '.', '.', '.', '.', '.', '.', '.', '.'],
        ['.', '.', '1', '.', '.', '.', '.', '.', '.'],
        ['.', '6', '7', '.', '.', '.', '.', '.', '9'],
        ['.', '.', '.', '.', '.', '.', '8', '1', '.'],
        ['.', '3', '.', '.', '.', '.', '.', '.', '6'],
        ['.', '.', '.', '.', '.', '7', '.', '.', '.'],
        ['.', '.', '.', '5', '.', '.', '.', '7', '.']]
the output should be
sudoku2(grid) = true;

For

grid = [['.', '.', '.', '.', '2', '.', '.', '9', '.'],
        ['.', '.', '.', '.', '6', '.', '.', '.', '.'],
        ['7', '1', '.', '.', '7', '5', '.', '.', '.'],
        ['.', '7', '.', '.', '.', '.', '.', '.', '.'],
        ['.', '.', '.', '.', '8', '3', '.', '.', '.'],
        ['.', '.', '8', '.', '.', '7', '.', '6', '.'],
        ['.', '.', '.', '.', '.', '2', '.', '.', '.'],
        ['.', '1', '.', '2', '.', '.', '.', '.', '.'],
        ['.', '2', '.', '.', '3', '.', '.', '.', '.']]
the output should be
sudoku2(grid) = false.

The given grid is not correct because there are two 1s in the second column. 
Each column, each row, and each 3 × 3 subgrid can only contain the numbers 1 through 9 one time.

Input/Output

[time limit] 4000ms (rb)
[input] array.array.char grid

A 9 × 9 array of characters, in which each character is either a digit from '1' to '9' or a period '.'.

[output] boolean

Return true if grid represents a valid Sudoku puzzle, otherwise return false.

THINK

If i grab each number in the matrix and store it's coordinate can I come up with a formula for
checking the appropriate indexes to see if there is a duplicate on the same row, column or 3x3 grid.


2 => [0, 4] => [[0, 3], [0, 5], [1, 3], [1, 4], [1, 5]]
9 => [0, 7]
6 => [1, 4] => [[0, 3], [0, 4], [0, 5], [1, 3], [1, 5], [2, 3], [2, 4], [2, 5]]
7 => [2, 0]
1 => [2, 1]
7 => [2, 4]
5 => [2, 5]
7 => [3, 1]
8 => [4, 4]
3 => [4, 5]
8 => [5, 2]
7 => [5, 4]
6 => [5, 7]
2 => [6, 5]
1 => [7, 1]
2 => [7, 3]
2 => [8, 1]
3 => [8, 4]


1  |2  | 4 |8
2^0|2^1|2^2|2^3|

DOC
describe "sudoku2" do
  def duplicates?(items)
    hash = {}
    items.reject { |x| x == 0 || x == "." }.each do |item|
      return true if hash[item]
      hash[item] = true
    end
    false
  end

  def sudoku2(grid)
    columns = 0.upto(8).map { |x| [x, []] }.to_h

    # find duplicates in each row
    0.upto(8) do |i|
      row = grid[i].map(&:to_i)
      return false if duplicates?(row.reject { |x| x == 0 })
      row.each_with_index do |x, column|
        columns[column].push(x.to_i) unless x == 0
      end
    end
    # find duplicates in each column
    columns.each do |key, column|
      return false if duplicates?(column)
    end
    # find duplicates in each 3x3 grid
    #PP.pp grid
    row, column = 0, 0
    until row > 8
      section = grid[row][column...(column + 3)] +
        grid[row + 1][column...(column + 3)] +
        grid[row + 2][column...(column + 3)]
      return false if duplicates?(section)

      column += 3
      if column > 8
        column = 0
        row += 3
      end
    end
    true
  end

  def sudoku2(grid)
    columns = Array.new(9) { Hash.new }
    rows = Array.new(9) { Hash.new }
    sub_grids = Array.new(9) { Hash.new }

    9.times do |i|
      9.times do |j|
        value = grid[i][j].to_i

        next if value.zero?
        return false if rows[i].key?(value)
        rows[i][value] = true

        return false if columns[j].key?(value)
        columns[j][value] = true

        index = (i / 3) * 3 + (j / 3)
        return false if sub_grids[index].key?(value)
        sub_grids[index][value] = true
      end
    end
    true
  end

  [
    { grid: [[".",".",".","1","4",".",".","2","."], [".",".","6",".",".",".",".",".","."], [".",".",".",".",".",".",".",".","."], [".",".","1",".",".",".",".",".","."], [".","6","7",".",".",".",".",".","9"], [".",".",".",".",".",".","8","1","."], [".","3",".",".",".",".",".",".","6"], [".",".",".",".",".","7",".",".","."], [".",".",".","5",".",".",".","7","."]], expected: true },
    { grid: [[".",".",".",".","2",".",".","9","."], [".",".",".",".","6",".",".",".","."], ["7","1",".",".","7","5",".",".","."], [".","7",".",".",".",".",".",".","."], [".",".",".",".","8","3",".",".","."], [".",".","8",".",".","7",".","6","."], [".",".",".",".",".","2",".",".","."], [".","1",".","2",".",".",".",".","."], [".","2",".",".","3",".",".",".","."]], expected: false },
    { grid: [[".",".","4",".",".",".","6","3","."], [".",".",".",".",".",".",".",".","."], ["5",".",".",".",".",".",".","9","."], [".",".",".","5","6",".",".",".","."], ["4",".","3",".",".",".",".",".","1"], [".",".",".","7",".",".",".",".","."], [".",".",".","5",".",".",".",".","."], [".",".",".",".",".",".",".",".","."], [".",".",".",".",".",".",".",".","."]], expected: false },
    { grid: [[".",".",".",".",".",".",".",".","2"], [".",".",".",".",".",".","6",".","."], [".",".","1","4",".",".","8",".","."], [".",".",".",".",".",".",".",".","."], [".",".",".",".",".",".",".",".","."], [".",".",".",".","3",".",".",".","."], ["5",".","8","6",".",".",".",".","."], [".","9",".",".",".",".","4",".","."], [".",".",".",".","5",".",".",".","."]], expected: true },
    { grid: [[".","9",".",".","4",".",".",".","."], ["1",".",".",".",".",".","6",".","."], [".",".","3",".",".",".",".",".","."], [".",".",".",".",".",".",".",".","."], [".",".",".","7",".",".",".",".","."], ["3",".",".",".","5",".",".",".","."], [".",".","7",".",".","4",".",".","."], [".",".",".",".",".",".",".",".","."], [".",".",".",".","7",".",".",".","."]], expected: true },
    { grid: [["7",".",".",".","4",".",".",".","."], [".",".",".","8","6","5",".",".","."], [".","1",".","2",".",".",".",".","."], [".",".",".",".",".","9",".",".","."], [".",".",".",".","5",".","5",".","."], [".",".",".",".",".",".",".",".","."], [".",".",".",".",".",".","2",".","."], [".",".",".",".",".",".",".",".","."], [".",".",".",".",".",".",".",".","."]], expected: false },
    { grid: [[".","4",".",".",".",".",".",".","."], [".",".","4",".",".",".",".",".","."], [".",".",".","1",".",".","7",".","."], [".",".",".",".",".",".",".",".","."], [".",".",".","3",".",".",".","6","."], [".",".",".",".",".","6",".","9","."], [".",".",".",".","1",".",".",".","."], [".",".",".",".",".",".","2",".","."], [".",".",".","8",".",".",".",".","."]], expected: false },
    { grid: [[".",".","5",".",".",".",".",".","."], [".",".",".","8",".",".",".","3","."], [".","5",".",".","2",".",".",".","."], [".",".",".",".",".",".",".",".","."], [".",".",".",".",".",".",".",".","9"], [".",".",".",".",".",".","4",".","."], [".",".",".",".",".",".",".",".","7"], [".","1",".",".",".",".",".",".","."], ["2","4",".",".",".",".","9",".","."]], expected: false },
    { grid: [[".",".",".",".",".",".",".",".","."], [".",".",".",".",".",".",".",".","."], [".","9",".",".",".",".",".",".","1"], ["8",".",".",".",".",".",".",".","."], [".","9","9","3","5","7",".",".","."], [".",".",".",".",".",".",".","4","."], [".",".",".","8",".",".",".",".","."], [".","1",".",".",".",".","4",".","9"], [".",".",".","5",".","4",".",".","."]], expected: false },
    { grid: [[".",".",".","2",".",".","6",".","."], [".",".",".","1",".",".",".",".","."], [".",".",".",".",".",".",".",".","."], [".",".",".","5",".","1",".",".","8"], [".","3",".",".",".",".",".",".","."], [".",".",".","9",".",".",".",".","3"], ["4",".",".",".",".",".",".",".","."], [".",".",".",".",".",".","3","8","."], [".",".",".",".",".",".",".",".","4"]], expected: true },
    { grid: [[".",".",".",".","8",".",".",".","."], [".",".",".",".",".",".","5",".","."], [".",".",".",".","4",".",".","2","."], [".",".",".","3",".","9",".",".","."], [".",".","1","8",".",".","9",".","."], [".",".",".",".",".","5","1",".","."], [".",".","3",".",".","8",".",".","."], [".","1","2",".","3",".",".",".","."], [".",".",".",".",".","7",".",".","1"]], expected: true },
    { grid: [[".",".",".",".",".",".","5",".","."], [".",".",".",".",".",".",".",".","."], [".",".",".",".",".",".",".",".","."], ["9","3",".",".","2",".","4",".","."], [".",".","7",".",".",".","3",".","."], [".",".",".",".",".",".",".",".","."], [".",".",".","3","4",".",".",".","."], [".",".",".",".",".","3",".",".","."], [".",".",".",".",".","5","2",".","."]], expected: false },
    { grid: [[".",".",".",".","4",".","9",".","."], [".",".","2","1",".",".","3",".","."], [".",".",".",".",".",".",".",".","."], [".",".",".",".",".",".",".",".","3"], [".",".",".","2",".",".",".",".","."], [".",".",".",".",".","7",".",".","."], [".",".",".","6","1",".",".",".","."], [".",".","9",".",".",".",".",".","."], [".",".",".",".",".",".",".","9","."]], expected: true },
    { grid: [[".","8","7","6","5","4","3","2","1"], ["2",".",".",".",".",".",".",".","."], ["3",".",".",".",".",".",".",".","."], ["4",".",".",".",".",".",".",".","."], ["5",".",".",".",".",".",".",".","."], ["6",".",".",".",".",".",".",".","."], ["7",".",".",".",".",".",".",".","."], ["8",".",".",".",".",".",".",".","."], ["9",".",".",".",".",".",".",".","."]], expected: true },
    { grid: [[".",".",".",".",".",".",".",".","."], ["4",".",".",".",".",".",".",".","."], [".",".",".",".",".",".","6",".","."], [".",".",".","3","8",".",".",".","."], [".","5",".",".",".","6",".",".","1"], ["8",".",".",".",".",".",".","6","."], [".",".",".",".",".",".",".",".","."], [".",".","7",".","9",".",".",".","."], [".",".",".","6",".",".",".",".","."]], expected: true },
    { grid: [[".",".",".",".",".",".",".",".","1"], [".",".",".",".",".","6",".",".","."], ["4",".",".",".",".",".","3","8","."], ["7",".",".",".",".",".",".",".","."], [".",".",".",".","5","3",".",".","."], [".",".",".",".","6","8",".",".","."], ["3",".",".","9",".",".",".",".","."], [".",".",".",".",".","2","1","1","."], [".",".",".",".",".",".",".",".","."]], expected: false },
    { grid: [[".","8",".",".",".",".",".",".","."], [".",".",".",".","2",".",".",".","."], [".","6",".",".",".",".","1",".","4"], [".",".",".","9",".",".","7",".","."], [".",".",".",".",".",".",".","4","."], [".",".","1",".",".","8",".",".","."], [".",".",".",".",".",".",".",".","."], [".",".",".",".",".","5",".","7","."], [".",".","3",".",".","5","6",".","."]], expected: false },
    { grid: [[".",".",".",".",".",".",".",".","."], [".",".","2",".",".",".",".",".","."], [".",".",".",".",".","2","7","1","."], [".",".",".",".",".",".",".",".","."], [".","2",".",".",".",".",".",".","."], [".","5",".",".",".",".",".",".","."], [".",".",".",".","9",".",".",".","8"], [".",".",".",".",".","1","6",".","."], [".",".",".",".","6",".",".",".","."]], expected: true },
    { grid: [[".",".",".","9",".",".",".",".","."], [".",".",".",".",".",".",".",".","."], [".",".","3",".",".",".",".",".","1"], [".",".",".",".",".",".",".",".","."], ["1",".",".",".",".",".","3",".","."], [".",".",".",".","2",".","6",".","."], [".","9",".",".",".",".",".","7","."], [".",".",".",".",".",".",".",".","."], ["8",".",".","8",".",".",".",".","."]], expected: false },
    { grid: [[".",".",".",".",".",".","8","3","."], ["2",".",".",".",".",".",".",".","."], ["7",".",".",".",".","7",".","9","5"], [".",".",".","1",".",".",".",".","2"], [".","8",".","9",".",".",".",".","."], [".",".","5","1","9",".",".",".","."], ["5",".",".",".",".",".",".",".","."], [".",".",".",".",".",".",".",".","."], [".",".",".",".",".",".",".",".","."]], expected: false },
  ].each do |x|
    it do
      expect(sudoku2(x[:grid])).to eql(x[:expected])
    end
  end
end
