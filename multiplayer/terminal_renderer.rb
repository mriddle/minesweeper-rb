require 'curses'
require 'tty/cursor'

class TerminalRenderer
  def initialize
    Curses.noecho
    Curses.nonl
    Curses.init_screen
    Curses.start_color
    Curses.clear
    Curses.curs_set(0)
  end

  def render(component)
    cursor = TTY::Cursor

    x = component.x
    y = component.y

    component.lines.each_with_index { |line, index|
      print cursor.move_to(x, y + index)
      print line
    }
  end
end
