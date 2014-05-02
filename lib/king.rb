module King

  extend self
  include Moves

  def illegal(board,x,y)
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
    elsif checked?(board,x,y)
      raise Game::IllegalMove, "King move into check"
    else
      :legal_move
    end
  end

  def checked?(board,x,y)
    enemies = board.enemies(self)
    x_diff = x-@x
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

  def initialize(x,y)
    super
    @start = true
    @direction = -1
  end

  def to_s
    "B!"
  end
end

