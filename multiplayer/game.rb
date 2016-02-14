require_relative 'input_manager'
require_relative 'terminal_renderer'
require_relative 'title_screen'

class Game
  def self.start
    self.new.loop
  end

  def loop
    count = 0

    while @running do
      process(@input_manager.commands)
      @terminal_renderer.render(TitleScreen::SPLASH_TITLE)
    end
  end

  private

  def initialize
    @running = true
    @input_manager = InputManager.new
    @terminal_renderer = TerminalRenderer.new
  end

  def process(input_commands)
    if input_commands.any?
      puts(input_commands)
    end
  end
end
