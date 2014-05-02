require_relative '../lib/chess'

require 'minitest/autorun'

class BishopTest < Minitest::Test

  def test_bishop_moves
    board = Board.new(:empty)
    bishop = WhiteBishop.new(4,4)
    board.place(bishop)
    board.move(bishop,5,5)
    assert_equal bishop, board.at(5,5)
  end

  def test_bishop_moves_more_than_one_space 
    board = Board.new(:empty)
    bishop = WhiteBishop.new(4,4)
    board.place(bishop)
    assert_silent do 
      board.move(bishop,3,3)
      board.move(bishop,4,4)
      board.move(bishop,5,5)
      board.move(bishop,4,4)
      board.move(bishop,7,7)
      board.move(bishop,4,4)
      board.move(bishop,1,1)
      board.move(bishop,4,4)
      board.move(bishop,5,3)
      board.move(bishop,4,4)

      board.move(bishop,3,5)
      board.move(bishop,4,4)
      board.move(bishop,0,0)
      board.move(bishop,4,4)
      board.move(bishop,1,7)
    end
  end

  def test_bishop_cannot_move_vertically
    board = Board.new(:empty)
    bishop = WhiteBishop.new(4,4)
    board.place(bishop)
    assert_raises(Game::IllegalMove) do
      board.move(bishop,4,0)
    end
  end

  def test_bishop_cannot_jump
    board = Board.new()
    bishop = board.at(2,0) 
    assert_raises(Game::IllegalMove) do
      board.move(bishop,5,3)
    end
  end

  def test_bishop_blocked_by_friend 
    board = Board.new()
    bishop = board.at(2,0) 
    assert_raises(Game::IllegalMove) do
      board.move(bishop,3,1)
    end
  end
end
