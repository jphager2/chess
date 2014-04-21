require_relative 'chess'

require 'minitest/autorun'

class PawnTest < MiniTest::Unit::TestCase
  
  def test_pawn_can_move_forward_one
    board = Board.new(:empty)
    pawn = WhitePawn.new(0,1)
    board.place(pawn)
    board.move(pawn,0,2)
    assert_equal pawn, board.at(0,2)
  end

  def test_pawn_can_move_forward_two_if_at_starting_position
    board = Board.new(:empty)
    pawn = WhitePawn.new(0,1)
    board.place(pawn)
    board.move(pawn,0,3)
    assert_equal pawn, board.at(0,3)
  end

  def test_pawn_cannot_move_forward_two_if_not_at_starting_position
    board = Board.new(:empty)
    pawn = WhitePawn.new(0,1)
    board.place(pawn)
    board.move(pawn,0,2)
    assert_raises(Game::IllegalMove) do
      board.move(pawn, 0,4)
    end
  end

  def test_pawn_cannot_attack_forward
    board = Board.new(:empty)
    pawn = WhitePawn.new(0,1)
    black_pawn = BlackPawn.new(0,3)
    board.place(pawn)
    board.place(black_pawn)
    board.move(black_pawn,0,2)
    assert_raises(Game::IllegalMove) do
      board.move(pawn,0,2)
    end
  end

  def test_pawn_can_attack_diagonally
    board = Board.new(:empty)
    pawn = WhitePawn.new(0,1)
    black_pawn = BlackPawn.new(1,2)
    board.place(pawn)
    board.place(black_pawn)
    board.move(pawn,1,2)
    assert_equal pawn, board.at(1,2)
  end

  def test_pawn_cannot_move_where_a_piece_of_the_same_color_is
    board = Board.new(:empty)
    pawn = WhitePawn.new(0,1)
    pawn2 = WhitePawn.new(0,2)
    board.place(pawn)
    board.place(pawn2)
    assert_raises(Game::IllegalMove) do
      board.move(pawn,0,2)
    end
  end

  def test_pawn_cannot_jump 
    board = Board.new(:empty)
    pawn = WhitePawn.new(0,1)
    black_pawn = BlackPawn.new(0,2)
    board.place(pawn)
    board.place(black_pawn)
    assert_raises(Game::IllegalMove) do
      board.move(pawn,0,3)
    end
  end

  def test_pawn_can_capture_en_passent
    board = Board.new(:empty)
    pawn = WhitePawn.new(0,1)
    pawn2 = BlackPawn.new(1,3)
    board.place(pawn)
    board.place(pawn2)
    board.move(pawn,0,3)
    board.move(pawn2,0,2)
    assert_equal pawn2, board.at(0,2)
  end

  def test_pawn_replaced_with_queen_when_it_reaches_the_back_row
    board = Board.new(:empty)
    pawn = WhitePawn.new(0,1)
    2.upto(7) {|y| board.move(pawn,0,y)}
    assert_kind_of WhiteQueen, board.at(0,7)
  end
end
