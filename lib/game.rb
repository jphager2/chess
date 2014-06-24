class Game

  attr_reader :turn
  def initialize
    @board = Board.new
    @king_to_check = {black: @board.at(3,0), white: @board.at(3,7)}
    @moves = []
    @turn = :white
    @over = false
  end

  def show
    puts @board
  end

  def over?
    @over
  end

  def at(x,y)
    @board.at(x,y)
  end

  def undo
    move = @moves.pop
    piece = at(*move[:piece][:point_b])
    new_piece = piece.class.new(*move[:piece][:point_a])
    capture = move[:capture]

    @board.remove(piece)
    @board.place(new_piece)
    @board.place(capture)

    switch_turn
  end

  def play(point_a, point_b) 
    raise Game::IllegalMove, "Game over" if @over

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
    switch_turn

    if @king_to_check[@turn].checked?(@board)
      undo
      raise Game::IllegalMove, "#{@turn}'s king is in check!"
    end
  end

  def resign
    @over = true
    print "#{@turn.to_s.capitalize} resigns, "
    switch_turn
    puts "#{@turn.to_s.capitalize} wins!" 
  end

  private
    def switch_turn 
      @turn = @turn == :white ? :black : :white
    end

  public 
    class IllegalMove < Exception 
    end
end


