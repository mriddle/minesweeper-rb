module Game
  class State
    def play(tiles, cursor_position)
      system 'clear'
      render(tiles, cursor_position)
      input = Game::Input.get_action(cursor_position)
      if input[:action] == :reveal
        play(
          Game::Board.reveal(tiles: tiles, position: input[:position]),
          input[:position]
        )
      end
      play(tiles, input[:position]) unless finished?(tiles)
    end

    def render(tiles, cursor_position)
      tiles.each_with_index do |row, row_index|
        print "#{row_index} "
        row.each do |tile|
          if cursor_position == tile.position && tile.bombed? && tile.revealed?
            print "#{tile.display.colorize(background: :white)}" + " ".colorize(background: :white)
          elsif cursor_position == tile.position
            print "#{tile.display.colorize(:white).colorize(:background => :blue)}" + " ".colorize(background: :white)
          else
            print "#{tile.display} ".colorize(:background => :white)
          end
        end
        print "\n"
      end
    end

    def finished?(tiles)
      won?(tiles) || lost?(tiles)
    end

    def won?(tiles)
      return false if lost?(tiles)
      tiles.flatten.all? { |tile| tile.revealed? && !tile.bombed? }
    end

    def lost?(tiles)
      tiles.flatten.any? { |tile| tile.bombed? && tile.revealed? }
    end
  end
end
