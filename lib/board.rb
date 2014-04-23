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
      pieces = []
      8.times do |x|
        pieces << BlackPawn.new(x,6) << WhitePawn.new(x,1)
      end

      pieces.each {|piece| place(piece)}
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
