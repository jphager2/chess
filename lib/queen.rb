module Queen 
  extend self

  def move(board,x,y)
    illegal(board,x,y)

    @x,@y = x,y
    place_on(board)
  end

  def illegal(board,x,y)
    possible_moves = []

    7.times do |coord|
      possible_moves += [
        [@x-coord, @y-coord],
        [@x,       @y-coord],
        [@x+coord, @y-coord],
        [@x-coord, @y],
        [@x+coord, @y],
        [@x-coord, @y+coord],
        [@x,       @y+coord],
        [@x+coord, @y+coord]
      ]
    end

    possible_moves = Board.board_safe(possible_moves)

    unless possible_moves.find {|move| move == [x,y]}
      raise Game::IllegalMove 
    end

    raise Game::IllegalMove, "Queens cannot jump" if jumped?(board,x,y)
  end

  def jumped?(board,x,y) 
    start, new = self.to_coord, [x,y]

    # find all the spaces ([x,y]) between start and new
    x_diff = (start.first - new.first)
    y_diff = (start.last - new.last) 

    moves_between = [] 

    if x_diff == 0 # vertical movement
      multiplyer = y_diff / y_diff.abs 

      ((y_diff.abs)-1).times do |aug|
        aug = (aug + 1) * multiplyer  
        moves_between << [x, y + aug] 
      end

    elsif y_diff == 0 # horizontal movement
      multiplyer = x_diff / x_diff.abs 

      ((x_diff.abs)-1).times do |aug|
        aug = (aug + 1) * multiplyer  
        moves_between << [x + aug, y] 
      end
    else # diagonal movement
      y_multiplyer = y_diff / y_diff.abs 
      x_multiplyer = x_diff / x_diff.abs

      ((x_diff.abs)-1).times do |aug|
        y_aug = (aug + 1) * y_multiplyer  
        x_aug = (aug + 1) * x_multiplyer
        moves_between << [x + x_aug, y + y_aug] 
      end
    end

    moves_between.any? {|coord| !board.at(*coord).empty?}
  end
end

class WhiteQueen < WhitePiece

  include Queen

  def to_s
    "WQ"
  end
end

class BlackQueen < BlackPiece

  include Queen

  def to_s
    "BQ"
  end
end
