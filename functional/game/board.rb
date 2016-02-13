module Game
  class Board
    def self.create_tiles(rows:, columns:)
      tiles(rows: rows, columns: columns) do |position|
        Tile.new(position: position, bombed: false, revealed: false)
      end
    end

    def self.add_bombs(tiles:, bomb_count:)
      tiles_for_bombs = tiles.flatten.sample(bomb_count)
      tiles(rows: tiles.length, columns: tiles[0].length) do |position|
        if tiles_for_bombs.detect { |tile| tile.position == position }
          Tile.new(position: position, bombed: true, revealed: false)
        else
          Tile.new(position: position, bombed: false, revealed: false)
        end
      end
    end

    def self.reveal(tiles:, position:)
      tile_to_reveal = tiles[position[0]][position[1]]
      tiles(rows: tiles.length, columns: tiles[0].length) do |tile_position|
        if tile_to_reveal.position == tile_position
          Tile.new(position: tile_position, bombed: tile_to_reveal.bombed?, revealed: true)
        else
          tile = tiles[tile_position[0]][tile_position[1]]
          Tile.new(position: tile_position, bombed: tile.bombed?, revealed: tile.revealed?)
        end
      end
    end

    private

    def self.tiles(rows:, columns:)
      Array.new(rows) do |row_index|
        Array.new(columns) do |column_index|
          yield [row_index, column_index]
        end
      end
    end
  end
end
