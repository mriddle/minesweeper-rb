class Board

  attr_accessor :grid, :cursor

  def initialize(grid, cursor)
    @grid = grid
    @cursor = cursor
  end

  def [](position)
    grid[position[0]][position[1]]
  end

  def []=(position, tile)
    grid[position[0]][position[1]] = tile
  end

  def won?
    return false if lost?
    grid.flatten.all? { |tile| tile.revealed? && !tile.bombed? }
  end

  def lost?
    grid.flatten.any? { |tile| tile.bombed? && tile.revealed? }
  end

  def populate(tiles)
    tiles.each_with_index do |row, row_index|
      row.each_index do |col_index|
        position = [row_index, col_index]
        self[position] = Tile.new(position, self)
      end
    end
  end

  def add_bombs(tiles)
    tiles.each(&:bombed!)
  end
end
