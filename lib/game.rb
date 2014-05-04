class Game

  attr_reader :kings
  def initialize
    @board = Board.new
    @kings = {white: @board.at(4,0), black: @board.at(3,7)}
    @moves = []
    @turn = :white
  end

  def show
    puts @board
  end

  def at(x,y)
    @board.at(x,y)
  end

  def undo
    move = @moves.pop
    piece = at(*move[:piece][:point_a])
    new_piece = piece.class.new(*move[:piece][:point_b])
    capture = move[:capture]

    @board.remove(piece)
    @board.place(new_piece)
    @board.place(capture)

    switch_turn
  end

  def play(point_a, point_b) 
    piece, at_destination = at(*point_a), at(*point_b) 

    unless piece.color == @turn
        raise Game::IllegalMove, 
          "It is #{@turn.to_s.capitalize}'s turn" 
    end

    @board.move(piece, *point_b)
    @moves << {
      piece: {
        point_a: point_a,
        point_b: point_b,
      },
      capture: at_destination,
    }

    if @kings[@turn].checked?(@board)
      undo
      raise Game::IllegalMove, "#{@turn}'s king is in check!"
    end

    switch_turn
  end

  private
    def switch_turn 
      @turn = @turn == :white ? :black : :white
    end

  public 
    class IllegalMove < Exception 
    end
end


