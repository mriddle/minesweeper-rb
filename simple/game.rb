
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
  end

  def self.start
    tiles = Array.new(Properties.rows) { Array.new(Properties.columns) }
    board = Board.new(tiles)
    board.populate
    tiles_for_bombs = tiles.flatten.sample(Properties.bomb_count)
    board.add_bombs(tiles_for_bombs)
    new(board).play
  end

  attr_accessor :board, :cursor

  def initialize(board)
    @board = board
    @cursor = Cursor.new(board)
  end

  def play
    until board.won? || board.lost?
      # Play game
      board.render
      puts "\nUse arrow keys to select a location. \nHit enter/space to reveal"
      cursor.prompt
    end
    puts "\n"
    board.render
    board.lost? ? puts("You lost :(".colorize(:light_red)) : puts("You won :)".colorize(:light_green))
  end

end
