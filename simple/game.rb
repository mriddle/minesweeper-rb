
class Game
  class Properties
    def self.bomb_count
      10
    end

    def self.rows
      8
    end

    def self.columns
      8
    end

    def self.boundary
      rows - 1
    end

    def self.starting_cursor_position
      [0,0]
    end
  end

  def self.start
    new.play
  end

  def play
    tiles = Array.new(Properties.rows) { Array.new(Properties.columns) }
    board = Board.new(tiles, Properties.starting_cursor_position)
    cursor = Cursor.new(board)
    board.populate(tiles)
    tiles_for_bombs = tiles.flatten.sample(Properties.bomb_count)
    board.add_bombs(tiles_for_bombs)

    until board.won? || board.lost?
      # Play game
      render(board.cursor, board.grid)
      puts "\nUse arrow keys to select a location. \nHit enter/space to reveal"
      cursor.prompt
    end
    puts "\n"
    render(board.cursor, board.grid)
    board.lost? ? puts("You lost :(".colorize(:light_red)) : puts("You won :)".colorize(:light_green))
  end

  def render(cursor, tiles)
    system 'clear'
    tiles.each_with_index do |row, row_index|
      print "#{row_index} "
      row.each { |tile| render_cursor_position(cursor, tile) }
      print "\n"
    end
  end

  def render_cursor_position(cursor, tile)
    if cursor == tile.position && tile.bombed? && tile.revealed?
      print "#{tile.display.colorize(background: :white)}" + " ".colorize(background: :white)
    elsif cursor == tile.position
      print "#{tile.display.colorize(:white).colorize(:background => :blue)}" + " ".colorize(background: :white)
    else
      print "#{tile.display} ".colorize(:background => :white)
    end
  end
end
