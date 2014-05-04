require_relative '../lib/chess'

require 'minitest/autorun'

class GameTest < Minitest::Test

  def game 
    game = Game.new
    white_pawn = game.at(1,1)
    game.play([1,1],[1,3])
    game
  end

  def white_in_check
    game = Game.new
    game.play([3,1],[3,3])
    game.play([4,6],[4,5])
    game.play([1,1],[1,3])
    game.play([5,7],[1,3])
    game
  end

  def test_can_play_white
    assert_kind_of WhitePawn, game.at(1,3)
  end

  def test_can_play_black
    this_game = game
    this_game.play([6,6],[6,5])
    assert_kind_of BlackPawn, this_game.at(6,5)
  end

  def test_game_can_undo_moves
    game = white_in_check
    2.times {game.undo}
    assert_kind_of EmptySpace, game.at(1,3)
  end

  def test_cannot_play_while_in_check
    game = white_in_check
    assert_raises(Game::IllegalMove) do
      game.play([0,1],[0,2])
    end
  end 

  def test_cannot_move_into_check
    game = white_in_check
    game.play([2,1],[2,2])
    game.play([6,6],[6,5])
    assert_raises(Game::IllegalMove) do
      game.play([2,2],[2,3])
    end
  end
end
