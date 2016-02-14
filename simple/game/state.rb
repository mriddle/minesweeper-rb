module Game
  class State
    def play(tiles, cursor_position)
      system 'clear'
      render(tiles, cursor_position)
      exit if finished?(tiles)
      input = Game::Input.get_action(cursor_position)

      revealed_tiles = nil
      if input[:action] == :reveal
        revealed_tiles = Game::Board.reveal(tiles: tiles, position: input[:position])
      end
      updated_tiles = revealed_tiles ? revealed_tiles : tiles
      play(updated_tiles, input[:position])
    end

    def render(tiles, cursor_position)
      afterEachRow = Proc.new { |n| print "\n" }
      tiles.each(afterEachRow) do |tile|
        bomb_count = Game::Board.neighbouring_bomb_count(tiles: tiles, position: tile.position)
        if cursor_position == tile.position
          print tile.display(bomb_count).colorize(:white).colorize(:background => :blue)
        else
          print tile.display(bomb_count)
        end
      end
    end

    def finished?(tiles)
      if won?(tiles) || lost?(tiles)
        lost?(tiles) ? puts("You lost :(".colorize(:light_red)) : puts("You won :)".colorize(:light_green))
        true
      end
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
