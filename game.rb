
class Game
  def self.start
    new(Board.new()).play
  end

  attr_accessor :board

  def initialize(board)
    @board = board
  end

  def play
    until board.won? || board.lost?
      # Play game
    end
    board.lost? ? puts(":(".colorize(:light_red)) : puts(":)".colorize(:light_green))
  end

end
