require 'pastel'
require_relative 'component/basic'
require_relative 'component/button'

class TitleScreen
  PASTEL = Pastel.new
  SPLASH_TITLE = [
    PASTEL.bright_white(" █▙ ▟█ ▀█▀  █▙  █  █▀▀▀  █▀▀▀█  █   █  █▀▀▀  █▀▀▀  █▀▀█  █▀▀▀  █▀▀█"),
    PASTEL.bright_cyan(" █ █ █  █   █ █ █  █▀▀▀  ▀▀▀▄▄  █ █ █  █▀▀▀  █▀▀▀  █▄▄█  █▀▀▀  █▄▄▀"),
    PASTEL.bright_blue(" █   █ ▄█▄  █  ▜█  █▄▄▄  █▄▄▄█  █▄▀▄█  █▄▄▄  █▄▄▄  █     █▄▄▄  █  █"),
  ].freeze

  def initialize
    @title = Component::Basic.new(lines: SPLASH_TITLE)

    @host_game_button = Component::Button.new(x: 18, y: 7)
    @host_game_button.title = "Host game"
    @host_game_button.select
    @join_game_button = Component::Button.new(x: 18, y: 10)
    @join_game_button.title = "Join game"
    @exit_button = Component::Button.new(x: 18, y: 13)
    @exit_button.title = "Exit"

    @button_selected_index = 0
    @buttons = [@host_game_button, @join_game_button, @exit_button]

    @components = []
    @components << @title
    @components += @buttons
  end

  def dirty_components
    @components.select(&:dirty?).tap { |o| o.each(&:mark_clean) }
  end

  def process(commands)
    commands.each do |command|
      case command
      when :up
        move_selection(-1)
      when :down
        move_selection(1)
      end
    end
  end

  private

  def move_selection(direction)
    @buttons[@button_selected_index].deselect

    @button_selected_index += direction
    @button_selected_index = 0 if @button_selected_index >= @buttons.length
    @button_selected_index = @buttons.length-1 if @button_selected_index < 0

    @buttons[@button_selected_index].select
  end
end
