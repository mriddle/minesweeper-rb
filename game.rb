
class Game
  def self.start

    new(Board.new.populate).play
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
      cursor.fetch
    end
    puts "\n"
    board.lost? ? puts("You lost :(".colorize(:light_red)) : puts("You won :)".colorize(:light_green))
  end

end
