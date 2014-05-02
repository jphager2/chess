require_relative '../lib/chess'

require 'minitest/autorun'

class KingTest < Minitest::Test

  def test_king_moves
    board = Board.new(:empty)
    king = WhiteKing.new(4,4)
    board.place(king)
    board.move(king,4,5)
    assert_equal king, board.at(4,5)
  end

  def test_king_can_move_in_any_direction
    board = Board.new(:empty)
    king = WhiteKing.new(4,4)
    board.place(king)
    assert_silent do 
      board.move(king,3,3)
      board.move(king,4,4)
      board.move(king,4,3)
      board.move(king,4,4)
      board.move(king,5,3)
      board.move(king,4,4)

      board.move(king,3,4)
      board.move(king,4,4)
      board.move(king,5,3)
      board.move(king,4,4)

      board.move(king,3,5)
      board.move(king,4,4)
      board.move(king,4,5)
      board.move(king,4,4)
      board.move(king,5,5)
    end
  end

  def test_king_cannot_move_into_check
    board = Board.new(:empty)
    king = WhiteKing.new(3,0)
    queen = BlackQueen.new(5,6)
    board.place(king)
    board.place(queen)
    assert_raises(Game::IllegalMove) do
      board.move(king,5,0)
    end
  end
  
  def test_king_cannot_move_through_check
    board = Board.new(:empty)
    king = WhiteKing.new(3,0)
    queen = BlackQueen.new(4,6)
    board.place(king)
    board.place(queen)
    assert_raises(Game::IllegalMove) do
      board.move(king,5,0)
    end
  end
end
