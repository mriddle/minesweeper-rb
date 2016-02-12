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

  def populate(tiles)
    tiles.each_with_index do |row, row_index|
      row.each_index do |col_index|
        position = [row_index, col_index]
        self[position] = Tile.new(position, self)
      end
    end
  end

  def add_bombs(tiles)
    tiles.each_with_object([]) do |tile, tiles_with_bombs|
      tile.bombed!
      tiles_with_bombs << tile
    end
  end
end
