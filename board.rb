class Board

  attr_accessor :grid, :cursor, :bombs, :rows, :cols, :boundary

  def initialize(rows: 8, cols: 8, bombs: 10)
    @bombs = bombs
    @rows = rows
    @cols = cols
    @boundary = rows - 1
    @grid = Array.new(rows) { Array.new(cols) }
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
      row.each do |tile|
        if cursor == tile.position
          print "#{tile.display.colorize(:white).colorize(:background => :blue)}" + " ".colorize(background: :white)
        else
          print "#{tile.display} ".colorize(:background => :white)
        end
      end
      print "\n"
    end
  end

  def populate
    grid.each_with_index do |row, row_index|
      row.each_index do |col_index|
        position = [row_index, col_index]
        self[position] = Tile.new(position)
      end
    end
    add_bombs
    self
  end


  def add_bombs
    grid.flatten.sample(@bombs).each(&:bombed!)
  end
end
