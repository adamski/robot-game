require './board.rb'

class Robot

  #@@directions = { up: {y: -1}, right: {x: 1}, down: {y: 1}, left: {x: -1} }
  @@directions = [ :up, :right, :down, :left ]
  @@max_moves = 10

  def initialize
    @board = Board.new
    @x = @y = 0
    @direction = :down
    @f1 = Array.new
    @f2 = Array.new
    @moves = 0
    @status = :playing
  end

  def is_block(x, y)
    @board.squares[ y ][ x ] == :block
  end

  def check_for_diamond
    if @board.squares[ @y ][ @x ] == :diamond
      @board.squares[ @y ][ @x ] = nil
    end
  end

  def check_status
    if @board.num_diamonds == 0
      @status = :won
    elsif @moves >= @@max_moves
      @status = :lost
    end
  end

  def move
    success = false
    case @direction
      when :up
        if @y > 0 && !is_block(@x, @y-1)
          @y -= 1
          success = true
        end
      when :down
        if @y < @board.height-1 && !is_block(@x, @y+1)
          @y += 1
          success = true
        end
      when :left
        if @x > 0 && !is_block(@x-1, @y)
          @x -= 1
          success = true
        end
      when :right
        if @x < @board.width-1 && !is_block(@x+1, @y)
          @x += 1
          success = true
        end
      else
        raise "Unknown direction #{@direction}"
    end
    @moves += 1
    check_for_diamond
    check_status
    success
  end

  def rotate(clock=1)
    i = @@directions.index(@direction) + clock
    @direction = @@directions.rotate(i).first
  end

  def rotate_anti
    rotate(-1)
  end

end

