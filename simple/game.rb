
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
    board.populate(tiles)
    tiles_for_bombs = tiles.flatten.sample(Properties.bomb_count)
    tiles = board.add_bombs(tiles_for_bombs)

    until won?(tiles.flatten) || lost?(tiles.flatten)
      # Play game
      render(board.cursor, board.grid)
      puts "\nUse arrow keys to select a location. \nHit enter/space to reveal"
      prompt(board)
    end
    puts "\n"
    render(board.cursor, board.grid)
    lost?(tiles) ? puts("You lost :(".colorize(:light_red)) : puts("You won :)".colorize(:light_green))
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

  def won?(tiles)
    return false if lost?(tiles)
    tiles.all? { |tile| tile.revealed? && !tile.bombed? }
  end

  def lost?(tiles)
    tiles.any? { |tile| tile.bombed? && tile.revealed? }
  end

  def prompt(board)
    cursor = board.cursor
    case Input.get_action
    when :reveal
      board[cursor].reveal!
    when :move_up
      board.cursor = move_up(cursor)
    when :move_down
      board.cursor = move_down(cursor)
    when :move_right
      board.cursor = move_right(cursor)
    when :move_left
      board.cursor = move_left(cursor)
    when :exit
      exit
    end
  end

  def move_up(cursor)
    [cursor[0] - 1, cursor[1]] if cursor[0] > 0
  end

  def move_down(cursor)
    [cursor[0] + 1, cursor[1]] if cursor[0] < Game::Properties.boundary
  end

  def move_right(cursor)
    [cursor[0], cursor[1] + 1] if cursor[1] < Game::Properties.boundary
  end

  def move_left(cursor)
    [cursor[0], cursor[1] - 1] if cursor[1] > 0
  end
end
