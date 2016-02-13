module Game
  class Tile
    attr_reader :position

    def initialize(position:, bombed:, revealed:)
      @position = position
      @bombed = bombed
      @revealed = revealed
    end

    def bombed?
      @bombed
    end

    def revealed?
      @revealed
    end

  def display
    if revealed? && bombed?
      "💣".colorize(:red)
    elsif revealed?
      "_".colorize(:black)
    else
      "*".colorize(:black)
    end
  end
  end
end
