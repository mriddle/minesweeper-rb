module Game
  class Board
    def create_tiles(rows:, columns:)
      tiles(rows: rows, columns: columns) do |position|
        Tile.new(position: position, bombed: false, revealed: false)
      end
    end

    def add_bombs(tiles:, bomb_count:)
      tiles_for_bombs = tiles.flatten.sample(bomb_count)
      tiles(rows: tiles.length, columns: tiles[0].length) do |position|
        if tiles_for_bombs.detect { |tile| tile.position == position }
          Tile.new(position: position, bombed: true, revealed: false)
        else
          Tile.new(position: position, bombed: tile.bombed?, revealed: tile.revealed?)
        end
      end
    end

    def reveal(tiles:, tile:)
      tiles(rows: tiles.length, columns: tiles[0].length) do |position|
        if tile.position == position
          Tile.new(position: position, bombed: tile.bombed?, revealed: true)
        else
          Tile.new(position: position, bombed: tile.bombed?, revealed: tile.revealed?)
        end
      end
    end

    private

    def tiles(rows:, columns:)
      Array.new(rows) do |row_index|
        Array.new(columns) do |column_index|
          yield [row_index, column_index]
        end
      end
    end
  end
end
