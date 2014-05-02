require_relative '../lib/chess'

require 'minitest/autorun'

class KnightTest < Minitest::Test

  def test_knight_moves
    board = Board.new(:empty)
    knight = WhiteKnight.new(4,4)
    board.place(knight)
    board.move(knight,6,5)
    assert_equal knight, board.at(6,5)
  end

  def test_knight_only_moves_in_l_shape
    board = Board.new(:empty)
    knight = WhiteKnight.new(4,4)
    board.place(knight)
    assert_raises(Game::IllegalMove) do
      board.move(knight,6,6)
    end
  end

  def test_knight_is_blocked_by_friend
    board = Board.new(:empty)
    knight = WhiteKnight.new(4,4)
    pawn = WhitePawn.new(6,6)
    board.place(knight)
    board.place(pawn)
    assert_raises(Game::IllegalMove) do
      board.move(knight,6,6)
    end  
  end

  def test_knight_can_capture_enemy 
    board = Board.new(:empty)
    knight = WhiteKnight.new(4,4)
    pawn = BlackPawn.new(6,5)
    board.place(knight)
    board.place(pawn)
    assert_silent do
      board.move(knight,6,5)
    end
  end
end
