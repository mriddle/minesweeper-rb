class Cursor
  INPUT = {
    enter: "\r",
    arrow_up: "\e[A",
    arrow_down: "\e[B",
    arrow_right: "\e[C",
    arrow_left: "\e[D",
    space: " ",
    exit: "\u0003"
  }

  attr_accessor :board

  def initialize(board)
    @board = board
  end

  def fetch
    input = get_action
    cursor = board.cursor
    if input == 'UP ARROW'
      board.cursor = move_up(cursor)
      'NO RETURN'
    elsif input == 'DOWN ARROW'
      board.cursor = move_down(cursor)
      'NO RETURN'
    elsif input == 'RIGHT ARROW'
      board.cursor = move_right(cursor)
      'NO RETURN'
    elsif input == 'LEFT ARROW'
      board.cursor = move_left(cursor)
      'NO RETURN'
    elsif input == 'REVEAL'
      board[cursor].reveal!
      'REVEAL'
    end
  end

  private

  def move_up(cursor)
    [cursor[0] - 1, cursor[1]] if cursor[0] > 0
  end

  def move_down(cursor)
    [cursor[0] + 1, cursor[1]] if cursor[0] < 8
  end

  def move_right(cursor)
    [cursor[0], cursor[1] + 1] if cursor[1] < 8
  end

  def move_left(cursor)
    [cursor[0], cursor[1] - 1] if cursor[1] > 0
  end

  def read_input
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

  def get_action
    case read_input
    when INPUT[:return] || INPUT[:space]
      return "REVEAL"
    when INPUT[:arrow_up]
      return "UP ARROW"
    when INPUT[:arrow_down]
      return "DOWN ARROW"
    when INPUT[:arrow_right]
      return "RIGHT ARROW"
    when INPUT[:arrow_left]
      return "LEFT ARROW"
    when INPUT[:exit]
      exit
      return "CONTROL-C"
    end
  end
end
