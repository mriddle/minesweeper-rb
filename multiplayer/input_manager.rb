require 'curses'

class InputManager
  KEY_MAP = {
    10 => :confirm, # enter
    27 => :cancel, # esc
    65 => :up,
    66 => :down,
    67 => :right,
    68 => :left,
    120 => :cancel, # x
    122 => :confirm, # z
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
