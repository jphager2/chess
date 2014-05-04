require_relative '../lib/chess'

require 'minitest/autorun'

class GameTest < Minitest::Test

  def game 
    game = Game.new
    white_pawn = game.at(1,1)
    game.white([1,1],[1,3])
    game
  end

  def test_can_play_white
    assert_kind_of WhitePawn game.at(1,3)
  end

  def test_can_play_black
    this_game = game
    this_game.black([6,6],[6,5])
    assert_kind_of BlackPawn game.at(6,5)
  end
end
