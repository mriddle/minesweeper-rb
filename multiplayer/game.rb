require_relative 'input_manager'

class Game
  def self.start
    self.new.loop
  end

  def loop
    count = 0

    while @running do
      process(@input_manager.commands)
    end
  end

  private

  def initialize
    @running = true
    @input_manager = InputManager.new
  end

  def process(input_commands)
    if input_commands.any?
      system('clear')
      puts(input_commands)
    end
  end
end
