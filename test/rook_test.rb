require_relative '../lib/chess'

require 'minitest/autorun'

class RookTest < Minitest::Test

  def test_rook_moves
    board = Board.new(:empty)
    rook = WhiteRook.new(4,4)
    board.place(rook)
    board.move(rook,4,5)
    assert_equal rook, board.at(4,5)
  end

  def test_rook_can_move_in_any_direction
    board = Board.new(:empty)
    rook = WhiteRook.new(4,4)
    board.place(rook)
    assert_silent do 
      board.move(rook,4,6)
      board.move(rook,4,4)
      board.move(rook,6,4)
      board.move(rook,4,4)

      board.move(rook,7,4)
      board.move(rook,4,4)
      board.move(rook,1,4)
      board.move(rook,4,4)
      board.move(rook,4,0)
    end
  end

  def test_rook_cannot_move_diagonally
    board = Board.new(:empty)
    rook = BlackRook.new(7,7)
    board.place(rook)
    assert_raises(Game::IllegalMove) do
      board.move(rook,4,4)
    end
  end
end
