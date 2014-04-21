class Game

  class IllegalMove < Exception 
  end
end

class Board 

  BackRow = { white: 7, black: 0 }

  attr_accessor :board, :en_passent
  def initialize(flag = false)
    @board = []
    8.times do |y| 
      row = [] 
      8.times {|x| row << EmptySpace.new(x,y)}
      @board << row
    end 

    unless flag
      :put_pieces_on_board
    end

    @en_passent = NullSpace.new
  end

  def place(piece)
    piece.place_on(self)
  end

  def remove(piece)
    piece.remove_from(self)
  end

  def at(x,y)
    board[y][x]
  end

  def move(piece, x, y)
    piece.move(self, x, y)
  end

  def self.board_safe(points)
    points.select do |point| 
      not(point.any? {|cord| cord < 0 or cord > 7})
    end 
  end

  def to_s
    out = "\s\s"
    out << (0..7).to_a.join(' ') << "\n" 

    @board.each_with_index do |row, i| 
      out << "#{i} " << (row.collect{|pc| pc.to_s}).join('') << "\n"
    end
    
    out
  end
end

class EmptySpace
  def initialize(x,y)
    @x, @y = x, y
    @color = :none
  end

  def place_on(board)
    board.board[@y][@x] = self
  end

  def remove_from(board)
    board.board[@y][@x] = EmptySpace.new(@x, @y)
  end

  def enemy_of?(piece)
    false
  end

  def friend_of?(piece)
    false
  end

  def to_coord
    [@x, @y]
  end

  def to_s
    "__"
  end
end

class NullSpace < EmptySpace
  def initialize
  end

  def to_coord
    [nil, nil]
  end

  def place_on(board)
  end
end

class BlackPiece < EmptySpace

  attr_reader :color

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

  attr_reader :color

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

module Pawn

  extend self

  # attempt to move the piece to x,y on the board
  def move(board,x,y)
    # check if it is an illegal move (raises Game::IllegalMove if it is)
    illegal?(board, x, y)

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

  def illegal?(board,x,y)
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
      end
    end

    raise Game::IllegalMove, error if error 
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

module Queen 
  extend self
end

class WhiteQueen < WhitePiece

  include Queen

  def initialize(x,y)
    super
  end
end

class BlackQueen < BlackPiece

  include Queen
end
