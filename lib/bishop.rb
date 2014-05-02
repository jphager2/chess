module Bishop

  extend self
  include Moves

  def illegal(board,x,y)
    possible_moves = []

    7.times do |coord|
      possible_moves += Board.board_safe(
        diagonal(coord) 
      )
    end

    if not(possible_moves.any? {|move| move == [x,y]})
      raise Game::IllegalMove, "#{x},#{y} is not a possible move" 
    elsif board.at(x,y).friend_of?(self)
      raise Game::IllegalMove, "#{x},#{y} is occupied by a friend"
    elsif jumped?(board,x,y) 
      raise Game::IllegalMove, "Bishops cannot jump" 
    else
      :legal_move
    end
  end
end

class WhiteBishop < WhitePiece 

  include Bishop

  def to_s
    "WB"
  end
end

class BlackBishop < BlackPiece

  include Bishop

  def to_s
    "BB"
  end
end
