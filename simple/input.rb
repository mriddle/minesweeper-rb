class Input
  def self.get_action
    case read_input
    when ACTIONS[:return] || ACTIONS[:space]
      :reveal
    when ACTIONS[:arrow_up]
      :move_up
    when ACTIONS[:arrow_down]
      :move_down
    when ACTIONS[:arrow_right]
      :move_right
    when ACTIONS[:arrow_left]
      :move_left
    when ACTIONS[:exit]
      :exit
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
end
