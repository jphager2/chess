module Pawn

  extend self

  # attempt to move the piece to x,y on the board
  def move(board,x,y)
    # check if it is an illegal move (raises Game::IllegalMove if it is)
    illegal(board, x, y)

    # make start false if it not already false
    !@start || @start = false

    # remove the piece from it's original position 
    board.remove(self)
    
    # save the piece if it can be taken by en passent
    board.en_passent = (@y-y).abs == 2 ? self : NullSpace.new 

    # update the coordinates
    @x, @y = x, y

    # replace with queen if on back row
    if @y == Board::BackRow[color]  
      board.place(@queen.new(@x,@y))
    else
      # or place on board
      place_on(board)
    end
  end

  def illegal(board,x,y)
    possible_moves = [
      [@x, @y+(1 * @direction)],
    ]
    possible_moves << [@x, @y+(2 * @direction)] if @start
    possible_moves = Board.board_safe(possible_moves)

    possible_attack_moves = Board.board_safe([
      [@x-1, @y+(1 * @direction)],
      [@x+1, @y+(1 * @direction)] 
    ])

    if board.at(x,y).friend_of?(self)
      error = "Your piece is blocking your path"
    elsif board.at(x,y).enemy_of?(self)
      unless possible_attack_moves.find {|move| move == [x,y]}
        error = "Cannot move this way!"
      end
    elsif board.en_passent.to_coord[0] == x
      unless possible_attack_moves.find {|move| move == [x,y]}
        error = "Cannot move this way!"
      else
        board.en_passent.remove_from(board)
      end
    else
      unless possible_moves.find {|move| move == [x,y]}
        error = "Cannot move here!"
      else
        if jumped?(board,x,y)
          raise Game::IllegalMove, "Pawns cannot jump!" 
        end
      end
    end

    raise Game::IllegalMove, error if error 
  end

  def jumped?(board,x,y)
    return false unless (@y-y).abs == 2
    !board.at(x,y-@direction).empty?
  end
end

class WhitePawn < WhitePiece 

  include Pawn 

  def initialize(x,y)
    super
    @start = true
    @direction = 1
    @queen = WhiteQueen
  end

  def to_s
    "WP"
  end
end

class BlackPawn < BlackPiece 

  include Pawn 

  def initialize(x,y)
    super
    @start = true
    @direction = -1
    @queen = BlackQueen
  end

  def to_s
    "BP"
  end
end

