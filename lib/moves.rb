module Moves

  def move(board,x,y)
    illegal(board,x,y)

    remove_from(board)
    @x,@y = x,y
    place_on(board)

    @start &&= false
  end

  def diagonal(coord)
    [
      [@x-coord, @y-coord],
      [@x+coord, @y-coord],
      [@x-coord, @y+coord],
      [@x+coord, @y+coord],
    ]
  end

  def horizontal(coord)
    [
      [@x-coord, @y],
      [@x+coord, @y],
    ]
  end

  def vertical(coord)
    [ 
      [@x,       @y-coord],
      [@x,       @y+coord],
    ]
  end
end


