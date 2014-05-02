module Rook

  extend self
  include Moves

  def illegal(board,x,y)
    possible_moves = []

    7.times do |coord|
      possible_moves += Board.board_safe(
        horizontal(coord) + vertical(coord) 
      )
    end

    if not(possible_moves.any? {|move| move == [x,y]})
      raise Game::IllegalMove, "#{x},#{y} is not a possible move" 
    elsif board.at(x,y).friend_of?(self)
      raise Game::IllegalMove, "#{x},#{y} is occupied by a friend"
    elsif jumped?(board,x,y) 
      raise Game::IllegalMove, "Rooks cannot jump" 
    else
      :legal_move
    end
  end
end

class WhiteRook < WhitePiece

  include Rook

  attr_reader :start
  def initialize(x,y)
    super
    @start = true
  end

  def to_s
    "WR"
  end
end

class BlackRook < BlackPiece

  include Rook

  attr_reader :start
  def initialize(x,y)
    super
    @start = true
  end

  def to_s
    "BR"
  end
end

