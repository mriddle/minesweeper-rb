module Game
  class Input
    def self.get_action(current_position)
      case read_input
      when ACTIONS[:arrow_up]
        move_up(current_position)
      when ACTIONS[:arrow_down]
        move_down(current_position)
      when ACTIONS[:arrow_right]
        move_right(current_position)
      when ACTIONS[:arrow_left]
        move_left(current_position)
      when ACTIONS[:exit]
        exit
      end
    end

    private

    ACTIONS = {
      enter: "\r",
      arrow_up: "\e[A",
      arrow_down: "\e[B",
      arrow_right: "\e[C",
      arrow_left: "\e[D",
      space: " ",
      exit: "\u0003"
    }

    def self.read_input
      STDIN.echo = false
      STDIN.raw!
      input = STDIN.getc.chr
      if input == "\e" then
        input << STDIN.read_nonblock(3) rescue nil
        input << STDIN.read_nonblock(2) rescue nil
      end
    ensure
      STDIN.echo = true
      STDIN.cooked!
      return input
    end

    def self.move_up(position)
      return position if position[0] == 0
      [position[0] - 1, position[1]]
    end

    def self.move_down(position)
      return position if position[0] == Game::Properties.boundary
      [position[0] + 1, position[1]]
    end

    def self.move_right(position)
      return position if position[1] == Game::Properties.boundary
      [position[0], position[1] + 1]
    end

    def self.move_left(position)
      return position if position[1] == 0
      [position[0], position[1] - 1]
    end
  end
end
