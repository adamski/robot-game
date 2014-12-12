class Board
  attr_reader :squares, :width, :height

  def initialize
    @width = 5
    @height = 3

    @squares = Array.new(@height) { Array.new(@width) }
    @squares[1][2] = :block
    @squares[2][3] = :block
    @squares[2][2] = :diamond
    @squares[2][4] = :diamond
  end

  def num_diamonds
    count = 0
    @squares.each do |row|
      row.each do |col|
        count += 1 if @squares[ row ][ col ] == :diamonds
      end
    end
  end
end
