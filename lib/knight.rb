module Knight

  extend self
  include Moves

  def illegal(board,x,y)
    possible_moves = [
      [@x+2, @y-1],
      [@x+2, @y+1],
      [@x-2, @y+1],
      [@x-2, @y-1],
      [@x+1, @y-2],
      [@x-1, @y-2],
      [@x+1, @y+2],
      [@x-1, @y+2],
    ]

    if not(possible_moves.any? {|move| move == [x,y]})
      raise Game::IllegalMove, "#{x},#{y} is not a possible move" 
    elsif board.at(x,y).friend_of?(self)
      raise Game::IllegalMove, "#{x},#{y} is occupied by a friend"
    else
      :legal_move
    end
  end
end

class WhiteKnight < WhitePiece

  include Knight

  def to_s
    "WK"
  end
end

class BlackKnight < BlackPiece

  include Knight

  def to_s
    "BK"
  end
end

