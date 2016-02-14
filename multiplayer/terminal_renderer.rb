require 'curses'
require 'tty/cursor'

class TerminalRenderer
  def initialize
    Curses.noecho
    Curses.nonl
    Curses.init_screen
    Curses.start_color
  end

  def render(lines, opts = {})
    cursor = TTY::Cursor

    lines.each_with_index { |line, index|
      print cursor.move_to(0, index)
      print line
    }
  end
end
