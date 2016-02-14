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

    def display(neigbouring_bomb_count)
      if revealed? && bombed?
        " 💣 ".colorize(:red)
      elsif revealed? && neigbouring_bomb_count > 0
        colourize_numbers(neigbouring_bomb_count)
      elsif revealed?
        " _ ".colorize(:black)
      else
        " * ".colorize(:black)
      end.colorize(background: :white)
    end

    def reveal!
      return self if revealed?
      self.class.new(position: position, bombed: bombed?, revealed: true)
    end

    def bomb!
      self.class.new(position: position, bombed: true, revealed: revealed?)
    end

    def colourize_numbers(count)
      case count
      when 3
        return " 3 ".colorize(:magenta)
      when 2
        return " 2 ".colorize(:blue)
      when 1
        return " 1 ".colorize(:green)
      else
        return " #{count.to_s} ".colorize(:light_red)
      end
    end
  end
end
