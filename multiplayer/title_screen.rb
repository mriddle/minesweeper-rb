require 'pastel'
require_relative 'component'

class TitleScreen
  PASTEL = Pastel.new
  SPLASH_TITLE = [
    PASTEL.bright_white(" █▙ ▟█ ▀█▀  █▙  █  █▀▀▀  █▀▀▀█  █   █  █▀▀▀  █▀▀▀  █▀▀█  █▀▀▀  █▀▀█"),
    PASTEL.bright_cyan(" █ █ █  █   █ █ █  █▀▀▀  ▀▀▀▄▄  █ █ █  █▀▀▀  █▀▀▀  █▄▄█  █▀▀▀  █▄▄▀"),
    PASTEL.bright_blue(" █   █ ▄█▄  █  ▜█  █▄▄▄  █▄▄▄█  █▄▀▄█  █▄▄▄  █▄▄▄  █     █▄▄▄  █  █"),
  ].freeze

  def initialize
    @components = []
    @components << Component.new(lines: SPLASH_TITLE)
  end

  def dirty_components
    @components.select(&:dirty?).tap { |o| o.each(&:mark_clean) }
  end
end
