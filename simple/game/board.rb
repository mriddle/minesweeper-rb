module Game
  class Board
    MOVE = [[0,1],[1,0],[-1,0],[0,-1],[1,1],[-1,-1],[-1,1],[1,-1]]

    def self.create_tiles(rows:, columns:)
      Game::Tiles.new(rows: rows, columns: columns) do |position|
        Tile.new(position: position, bombed: false, revealed: false)
      end
    end

    def self.add_bombs(tiles:, bomb_count:)
      tiles_for_bombs = tiles.flatten.sample(bomb_count)
      Game::Tiles.new(rows: tiles.rows, columns: tiles.columns) do |tile_position|
        tile = tiles[tile_position]
        if tiles_for_bombs.include?(tile)
          tile.bomb!
        else
          tile
        end
      end
    end

    def self.reveal(position:, tiles:)
      neighbours = neighbours(tiles: tiles, position: position)
      Game::Tiles.new(rows: tiles.rows, columns: tiles.columns) do |tile_position|
        tile = tiles[tile_position]
        if position == tile_position || neighbours.reject(&:bombed?).include?(tile)
          tile.reveal!
        else
          tile
        end
      end
    end

    def self.neighbours(tiles:, position:)
      MOVE.map do |move|
        neighbour_position = [move[0] + position[0] , move[1]+position[1]]
        if neighbour_position.all? { |cord| cord.between?(0, Game::Properties.boundary) }
           tiles[neighbour_position]
        end
      end.compact
    end

    def self.neighbouring_bomb_count(tiles:, position:)
      neighbours(tiles: tiles, position: position).count(&:bombed?)
    end
  end
end
