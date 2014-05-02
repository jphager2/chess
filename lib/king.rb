module King

  extend self
  include Moves

  def illegal(board,x,y)
    possible_moves = []

    possible_moves += Board.board_safe(
        diagonal(1) + horizontal(1) + vertical(1) 
    )

    if not(possible_moves.any? {|move| move == [x,y]})
      raise Game::IllegalMove, "#{x},#{y} is not a possible move" 
    elsif board.at(x,y).friend_of?(self)
      raise Game::IllegalMove, "#{x},#{y} is occupied by a friend"
    else
      :legal_move
    end
  end
end

class WhiteKing < WhitePiece
 
  include King

  def to_s
    "W!"
  end
end

class BlackKing < BlackPiece
  
  include King

  def to_s
    "B!"
  end
end

