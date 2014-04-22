require_relative 'chess'

require 'minitest/autorun'

class QueenTest < MiniTest::Unit::TestCase

  def test_queen_moves
    board = Board.new(:empty)
    queen = WhiteQueen.new(4,4)
    board.place(queen)
    board.move(queen,4,5)
    assert_equal queen, board.at(4,5)
  end

  def test_queen_can_move_in_any_direction
    board = Board.new(:empty)
    queen = WhiteQueen.new(4,4)
    board.place(queen)
    assert_silent do 
      board.move(queen,3,3)
      board.move(queen,4,4)
      board.move(queen,4,3)
      board.move(queen,4,4)
      board.move(queen,5,3)
      board.move(queen,4,4)

      board.move(queen,3,4)
      board.move(queen,4,4)
      board.move(queen,5,3)
      board.move(queen,4,4)

      board.move(queen,3,5)
      board.move(queen,4,4)
      board.move(queen,4,5)
      board.move(queen,4,4)
      board.move(queen,5,5)
    end
  end

  def test_queen_can_move_in_any_direction_for_any_number_of_spaces 
    board = Board.new(:empty)
    queen = WhiteQueen.new(4,4)
    board.place(queen)
    assert_silent do 
      board.move(queen,0,0)
      board.move(queen,4,4)

      board.move(queen,4,2)
      board.move(queen,4,4)

      board.move(queen,7,1)
      board.move(queen,4,4)

      board.move(queen,5,5)
      board.move(queen,4,4)

      board.move(queen,4,7)
      board.move(queen,4,4)

      board.move(queen,1,7)
      board.move(queen,4,4)
      
      board.move(queen,2,4)
      board.move(queen,4,4)

      board.move(queen,6,4)
    end
  end

  def test_queen_cannot_move_in_an_l
    board = Board.new(:empty)
    queen = WhiteQueen.new(4,4)
    board.place(queen)
    assert_raises(Game::IllegalMove) do
      board.move(queen,6,5)
    end
  end

  def test_queen_cannot_jump
    board = Board.new(:empty)
    queen = WhiteQueen.new(4,4)
    pawn = BlackPawn.new(1,1)
    board.place(queen)
    board.place(pawn)
    assert_raises(Game::IllegalMove) do 
      board.move(queen,0,0)
    end
  end
end
