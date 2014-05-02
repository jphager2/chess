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
end
