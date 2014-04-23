class BlackPiece < EmptySpace

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

class WhitePiece < EmptySpace

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

