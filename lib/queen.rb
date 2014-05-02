module Queen 
  extend self
  include Moves

  def move(board,x,y)
    illegal(board,x,y)

    remove_from(board)
    @x,@y = x,y
    place_on(board)
  end

  def illegal(board,x,y)
    possible_moves = []

    7.times do |coord|
      possible_moves += Board.board_safe(
        diagonal(coord) + horizontal(coord) + vertical(coord) 
      )
    end

    if not(possible_moves.any? {|move| move == [x,y]})
      raise Game::IllegalMove, "#{x},#{y} is not a possible move" 
    elsif board.at(x,y).friend_of?(self)
      raise Game::IllegalMove, "#{x},#{y} is occupied by a friend"
    elsif jumped?(board,x,y) 
      raise Game::IllegalMove, "Queens cannot jump" 
    else
      :legal_move
    end
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
