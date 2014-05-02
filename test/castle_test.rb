require_relative '../lib/chess'

require 'minitest/autorun'

class CastleTest < Minitest::Test

  def test_rook_moves_when_king_castles_right
    board = Board.new(:empty)
    king = BlackKing.new(4,7)
    rook = BlackRook.new(7,7)
    board.place(king)
    board.place(rook)
    board.move(king,6,7)
    assert_equal rook, board.at(5,7) 
  end

  def test_rook_moves_when_king_castles_left
    board = Board.new(:empty)
    king = BlackKing.new(4,7)
    rook = BlackRook.new(0,7)
    board.place(king)
    board.place(rook)
    board.move(king,2,7)
    assert_equal rook, board.at(3,7)
  end

  def test_black_king_can_move_to_castle_right
    board = Board.new(:empty)
    king = BlackKing.new(4,7)
    rook = BlackRook.new(7,7)
    board.place(king)
    board.place(rook)
    assert_silent do
      board.move(king,6,7)
    end
  end

  def test_black_king_can_move_to_castle_left
    board = Board.new(:empty)
    king = BlackKing.new(4,7)
    rook = BlackRook.new(0,7)
    board.place(king)
    board.place(rook)
    assert_silent do
      board.move(king,2,7)
    end
  end

  def test_white_king_can_move_to_castle_right
    board = Board.new(:empty)
    king = WhiteKing.new(3,0)
    rook = WhiteRook.new(7,0)
    board.place(king)
    board.place(rook)
    assert_silent do
      board.move(king,5,0)
    end
  end

  def test_white_king_can_move_to_castle_left
    board = Board.new(:empty)
    king = WhiteKing.new(3,0)
    rook = WhiteRook.new(0,0)
    board.place(king)
    board.place(rook)
    assert_silent do
      board.move(king,1,0)
    end
  end

  def test_king_cannot_jump_to_castle
    board = Board.new(:empty)
    king = WhiteKing.new(3,0)
    queen = WhiteQueen.new(4,0)
    board.place(king)
    board.place(queen)
    assert_raises(Game::IllegalMove) do
      board.move(king,5,0)
    end
  end
end
