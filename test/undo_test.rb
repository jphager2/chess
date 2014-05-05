require_relative '../lib/chess'

require 'minitest/autorun'

class UndoTest < Minitest::Test

  def white_in_check
    game = Game.new
    game.play([4,1],[4,3])
    game.play([3,6],[3,5])
    game.play([6,1],[6,3])
    game.play([2,7],[6,3])
    game
  end

  def test_game_can_undo_moves
    game = white_in_check
    2.times {game.undo}
    assert_kind_of EmptySpace, game.at(6,3)
  end
  
  def test_undo_adds_removed_pieces
    game = Game.new
    game.play([4,1],[4,3])
    game.play([3,6],[3,4])
    game.play([4,3],[3,4])
    game.undo
    assert_kind_of BlackPawn, game.at(3,4)
  end
  
  def test_undo_reverses_the_last_move
    game = Game.new
    game.play([4,1],[4,3])
    game.play([3,6],[3,4])
    game.play([4,3],[3,4])
    game.undo
    assert_kind_of WhitePawn, game.at(4,3)
  end

end
