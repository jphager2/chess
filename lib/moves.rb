module Moves
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


