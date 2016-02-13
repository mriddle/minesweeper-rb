module Game
  class Board
    def create_tiles(rows:, columns:)
      Array.new(rows) do |row_index|
        Array.new(columns) do |column_index|
          Tile.new(position: [row_index, column_index], bombed: false, revealed: false)
        end
      end
    end

    def add_bombs(tiles:, bomb_count:)
      tiles_for_bombs = tiles.flatten.sample(bomb_count)
      rows = tiles.length
      columns = tiles[0].length
      Array.new(rows) do |row_index|
        Array.new(columns) do |column_index|
          position = [row_index, column_index]
          if tiles_for_bombs.detect { |tile| tile.position == position }
            Tile.new(position: position, bombed: true, revealed: false)
          else
            Tile.new(position: position, bombed: false, revealed: false)
          end
        end
      end
    end
  end
end
