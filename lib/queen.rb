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
