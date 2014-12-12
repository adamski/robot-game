require './board.rb'

class Robot
  attr_reader :status

  #@@directions = { up: {y: -1}, right: {x: 1}, down: {y: 1}, left: {x: -1} }
  @@directions = [ :up, :right, :down, :left ]
  @@max_moves = 10
  @@max_function_commands = 4

  def initialize( f1, f2 )
    @board = Board.new
    @x = @y = 0
    @direction = :down
    @f1 = f1
    @f2 = f2
    @moves = 0
    @status = :playing
  end

  def report
    "x:#{@x} y:#{@y} moves:#{@moves} direction:#{@direction} diamonds remaining:#{@board.num_diamonds}"
  end

  def move(command)
    if self.respond_to?(command) && %w[fwd rc ra f1 f2].include?(command)
      self.send(command)
      @moves += 1
      check_status
      report
    end
  end

  #command shortcuts
  def fwd
    forward
  end

  def rc
    rotate
  end

  def ra
    rotate_anti
  end

  def f1
    invoke_function(@f1)
  end

  def f2
    invoke_function(@f2)
  end

  def invoke_function(function)
    if function && function.class == Array
      count = 0
      function.each do |command|
        if self.respond_to?(command) && %w[fwd rc ra].include?(command)
          self.send(command)
          count += 1
        end
        break if count >= @@max_function_commands
      end
    end

  end

  def is_block( x, y )
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

  def forward
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
    check_for_diamond
    #check_status
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

