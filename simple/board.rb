class Board

  attr_accessor :grid, :cursor

  def initialize(grid)
    @grid = grid
    @cursor = [0,0]
  end

  def [](position)
    grid[position[0]][position[1]]
  end

  def []=(position, tile)
    grid[position[0]][position[1]] = tile
  end

  def won?
    return false if lost?
    grid.flatten.all? { |tile| tile.revealed? }
  end

  def lost?
    grid.flatten.any? { |tile| tile.bombed? && tile.revealed? }
  end

  def render
    system 'clear'
    grid.each_with_index do |row, row_index|
      print "#{row_index} "
      row.each { |tile| update_position(tile) }
      print "\n"
    end
  end

  def populate
    grid.each_with_index do |row, row_index|
      row.each_index do |col_index|
        position = [row_index, col_index]
        self[position] = Tile.new(position, self)
      end
    end
  end

  def add_bombs(tiles)
    tiles.each(&:bombed!)
  end

  private

  def update_position(tile)
    if cursor == tile.position && tile.bombed?
      print "#{tile.display.colorize(background: :white)}" + " ".colorize(background: :white)
    elsif cursor == tile.position
      print "#{tile.display.colorize(:white).colorize(:background => :blue)}" + " ".colorize(background: :white)
    else
      print "#{tile.display} ".colorize(:background => :white)
    end
  end
end
