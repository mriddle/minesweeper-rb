module Game
  class Board
    def self.create_tiles(rows:, columns:)
      Game::Tiles.new(rows: rows, columns: columns) do |position|
        Tile.new(position: position, bombed: false, revealed: false)
      end
    end

    def self.add_bombs(tiles:, bomb_count:)
      tiles_for_bombs = tiles.flatten.sample(bomb_count)
      Game::Tiles.new(rows: tiles.rows, columns: tiles.columns) do |position|
        if tiles_for_bombs.detect { |tile| tile.position == position }
          Tile.new(position: position, bombed: true, revealed: false)
        else
          Tile.new(position: position, bombed: false, revealed: false)
        end
      end
    end

    def self.reveal(tiles:, position:)
      Game::Tiles.new(rows: tiles.rows, columns: tiles.columns) do |tile_position|
        tile = tiles[tile_position]
        if position == tile_position
          Tile.new(position: tile_position, bombed: tile.bombed?, revealed: true)
        else
          Tile.new(position: tile_position, bombed: tile.bombed?, revealed: tile.revealed?)
        end
      end
    end
  end
end
