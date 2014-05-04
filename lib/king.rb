module King

  extend self
  include Moves

  def illegal(board,x,y)
    x_diff = x-@x
    possible_moves = []

    possible_moves += Board.board_safe(
        diagonal(1) + horizontal(1) + vertical(1) 
    )

    if @start #castling
      possible_moves += [
        [@x-(2 * @direction), @y], [@x+(2 * @direction), @y] 
      ]
    end

    if not(possible_moves.any? {|move| move == [x,y]})
      raise Game::IllegalMove, "#{x},#{y} is not a possible move" 
    elsif board.at(x,y).friend_of?(self)
      raise Game::IllegalMove, "#{x},#{y} is occupied by a friend"
    elsif jumped?(board,x,y)
      raise Game::IllegalMove, "Kings can't jump"
    elsif checked?(board,x,y,x_diff)
      raise Game::IllegalMove, "King can't move into check"
    else
      castle(board,x,y,x_diff) if (x_diff).abs > 1
      :legal_move
    end
  end

  def castle(board,x,y,x_diff)
    direction = x_diff/x_diff.abs

    # get rook, raise illegal move unless start, else move the rook
    if direction > 0 # right
      rook = board.at(7,y)
      rook_x = x-1
    else             # left
      rook = board.at(0,y)
      rook_x = x+1
    end

    if rook.is_a?(Rook) && rook.friend_of?(self) && rook.start
      board.move(rook,rook_x,y)
    else
      raise Game::IllegalMove, "King cannot castle this way, now"
    end
  end

  def checked?(board,x = @x, y = @y, x_diff = 0)
    enemies = board.enemies(self)
    spaces = [[x,y]]

    if x_diff.abs > 1 #castling
      spaces << [x - 1*(x_diff/x_diff.abs), y]
    end

    enemies.each do |enemy|
      spaces.each do |space|
        begin
          enemy.illegal(board,*space)
          return true
        rescue Game::IllegalMove
          :not_checked
        end
      end
    end

    return false 
  end
end

class WhiteKing < WhitePiece
 
  include King

  attr_reader :start
  def initialize(x,y)
    super
    @start = true
    @direction = 1
  end

  def to_s
    "W!"
  end
end

class BlackKing < BlackPiece
  
  include King

  attr_reader :start
  def initialize(x,y)
    super
    @start = true
    @direction = -1
  end

  def to_s
    "B!"
  end
end

