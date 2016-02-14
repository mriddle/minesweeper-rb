module Game
  class Tiles
    include Enumerable

    attr_reader :all, :rows, :columns

    def initialize(rows:, columns:)
      @rows = rows
      @columns = columns
      @all = Array.new(rows) do |row_index|
        Array.new(columns) do |column_index|
          yield [row_index, column_index]
        end
      end
    end

    def flatten
      all.flatten
    end

    def [](position)
      all[position[0]][position[1]]
    end

    def each(afterRow = Proc.new)
      all.each do |row|
        row.each do |tile|
          yield tile
        end
        afterRow.call
      end
    end
  end
end
