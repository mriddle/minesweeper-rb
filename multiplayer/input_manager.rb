require 'curses'

class InputManager
  KEY_MAP = {
    65 => :up,
    66 => :down,
    67 => :right,
    68 => :left,
  }.freeze

  def initialize
    Curses.noecho
    Curses.timeout = 0
  end

  def commands
    buffer = []

    while char = Curses.getch
      buffer << char.ord
    end

    buffer.map { |key_code|
      KEY_MAP.fetch(key_code, nil)
    }.compact
  end
end
