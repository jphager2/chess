#!/usr/bin/env ruby

require_relative 'lib/chess'

game = Game.new

def game.prompt_for_turn
  puts "Resign or enter piece coordinates then move coordinate." 
  print "Format: x,y:a,b for move (e.g. 3,1:3,3): "
  ans = gets.chomp.downcase.gsub(/\s/, '')

  if ans =~ /res/
    self.resign 
    sleep(3)
    nil
  else
    ans.split(':').map do |point| 
      point.split(',').map {|i| i.to_i}
    end
  end
end 

system "clear"
game.show

until game.over?
  begin 
    puts "#{game.turn.to_s.capitalize}'s turn"
    ans = game.prompt_for_turn
    game.play(*ans) if ans

    system "clear"
    game.show
  rescue Game::IllegalMove
    next
  end
end

system "clear"
