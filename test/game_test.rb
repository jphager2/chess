require_relative '../lib/chess'

require 'minitest/autorun'
require 'stringio'

class GameTest < Minitest::Test

  def game 
    game = Game.new
    white_pawn = game.at(1,1)
    game.play([1,1],[1,3])
    game
  end

  def white_in_check
    game = Game.new
    game.play([4,1],[4,3])
    game.play([3,6],[3,5])
    game.play([6,1],[6,3])
    game.play([2,7],[6,3])
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

  def test_cannot_play_while_in_check
    game = white_in_check
    assert_raises(Game::IllegalMove) do
      game.play([0,1],[0,2])
    end
  end 

  def test_cannot_move_into_check
    game = white_in_check
    game.play([5,1],[5,2])
    game.play([6,6],[6,5])
    assert_raises(Game::IllegalMove) do
      game.play([5,2],[5,3])
    end
  end

  def test_player_can_resign
    out, temp = StringIO.new, $stdout
    $stdout = out

    game = white_in_check
    game.resign

    $stdout = temp
    out.rewind

    assert_match /White resigns, Black wins!/, out.read
  end
end
