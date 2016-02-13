module Game
  class Board
    def create_tiles(rows:, columns:)
      Array.new(rows) do |row_index|
        Array.new(columns) do |column_index|
          Tile.new(position: [row_index, column_index], bombed: false, revealed: false)
        end
      end
    end
  end
end
