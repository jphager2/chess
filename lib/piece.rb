class Piece < EmptySpace
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

class BlackPiece < Piece 

  def initialize(x,y)
    super
    @color = :black
  end

  def enemy_of?(piece)
    piece.color == :white
  end
  
  def friend_of?(piece)
    piece.color == color
  end
end

class WhitePiece < Piece

  def initialize(x,y)
    super 
    @color = :white 
  end

  def enemy_of?(piece)
    piece.color == :black 
  end 

  def friend_of?(piece)
    piece.color == color
  end
end 

