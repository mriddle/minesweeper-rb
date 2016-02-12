class Tile

  attr_accessor :state, :position

  def initialize(position)
    @position = position
  end

  def bombed!
    @state = :bombed
  end

  def reveal!
    @state = :revealed
  end

  def bombed?
    state == :bombed
  end

  def revealed?
    state == :revealed
  end

  def display
    case state
    when :revealed
      "_".colorize(:black)
    else
      "*".colorize(:black)
    end
  end

end
