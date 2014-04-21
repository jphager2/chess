module Queen 
  extend self
end

class WhiteQueen < WhitePiece

  include Queen

  def to_s
    "WQ"
  end
end

class BlackQueen < BlackPiece

  include Queen

  def to_s
    "BQ"
  end
end
