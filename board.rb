class Board

  attr_accessor :grid

  def initialize(rows: 8, cols: 8, bombs: 10)
    @grid = Array.new(rows) { Array.new(cols) { Tile.new } }
  end

  def won?
    return false if lost?
    grid.flatten.all? { |tile| tile.revealed? }
  end

  def lost?
    grid.flatten.any? { |tile| tile.bombed? }
  end

end
