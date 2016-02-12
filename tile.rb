class Tile
  attr_accessor :position

  def initialize(position)
    @position = position
  end

  def bombed!
    @bombed = true
  end

  def reveal!
    @revealed = true
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
