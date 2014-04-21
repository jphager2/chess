class Game

  class IllegalMove < Exception 
  end
end

class Board 

  attr_accessor :board
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
  end

  def place(piece)
    piece.place(self)
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

  def place(board)
    board.board[@y][@x] = self
  end

  def enemy_of?(piece)
    false
  end

  def to_s
    "__"
  end
end

class Pawn < EmptySpace

  def initialize(x,y)
    super
    @start = true
  end

  def move(board,x,y)
    illegal?(board, x, y)

    !@start || @start = false
    board.place(EmptySpace.new(@x, @y))
    @x, @y = x, y
    place(board)
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
        error = "Cannot move attack this way!"
      end
    else
      unless possible_moves.find {|move| move == [x,y]}
        error = "Cannot move here!"
      end
    end

    raise Game::IllegalMove, error if error 
  end
end

module Black

  extend self

  attr_reader :color

  def enemy_of?(piece)
    piece.color == :white
  end
  
  def friend_of?(piece)
    piece.color == color
  end
end

module White

  extend self

  attr_reader :color

  def enemy_of?(piece)
    piece.color == :black 
  end 

  def friend_of?(piece)
    piece.color == color
  end
end 


class WhitePawn < Pawn

  include White 

  def initialize(x,y)
    super
    @direction = 1
    @color = :white
  end

  def to_s
    "WP"
  end
end

class BlackPawn < Pawn

  include Black

  def initialize(x,y)
    super
    @direction = -1
    @color = :black
  end

  def to_s
    "BP"
  end
end


