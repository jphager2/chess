class EmptySpace

  attr_reader :color
  def initialize(x,y)
    @x, @y = x, y
    @color = :none
  end

  def place_on(board)
    board.board[@y][@x] = self
  end

  def remove_from(board)
    board.board[@y][@x] = EmptySpace.new(@x, @y)
  end

  def empty?
    color == :none 
  end

  def enemy_of?(piece)
    false
  end

  def friend_of?(piece)
    false
  end

  def to_coord
    [@x, @y]
  end

  def to_s
    "__"
  end
end

class NullSpace < EmptySpace
  def initialize
  end

  def to_coord
    [nil, nil]
  end

  def place_on(board)
  end
end


