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

  def prompt
    cursor = board.cursor
    position = get_position(read_input, cursor)
    if position
      board.cursor = position
    else
      board[cursor].reveal!
    end
    cursor = board.cursor
  end

  private

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

  def get_position(input, cursor)
    case input
    when INPUT[:return] || INPUT[:space]
      nil
    when INPUT[:arrow_up]
      move_up(cursor)
    when INPUT[:arrow_down]
      move_down(cursor)
    when INPUT[:arrow_right]
      move_right(cursor)
    when INPUT[:arrow_left]
      move_left(cursor)
    when INPUT[:exit]
      exit
    end
  end

  def move_up(cursor)
    [cursor[0] - 1, cursor[1]] if cursor[0] > 0
  end

  def move_down(cursor)
    [cursor[0] + 1, cursor[1]] if cursor[0] < board.boundary
  end

  def move_right(cursor)
    [cursor[0], cursor[1] + 1] if cursor[1] < board.boundary
  end

  def move_left(cursor)
    [cursor[0], cursor[1] - 1] if cursor[1] > 0
  end
end
