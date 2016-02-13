#!/usr/bin/env ruby

require 'yaml'
require 'pry'
require 'colorize'

module Game
  class Properties
    def initialize(difficulty:)
      @settings = YAML.load_file('settings.yml')['level'][difficulty]
    end

    def bomb_count
      @settings['bomb_count']
    end

    def rows
      @settings['rows']
    end

    def columns
      @settings['columns']
    end

    def boundary
      @settings['rows'] - 1
    end
  end
end

module Game
  class Tile
    attr_reader :position

    def initialize(position:, bombed:, revealed:)
      @position = position
      @bombed = bombed
      @revealed = revealed
    end

    def bombed?
      @bombed
    end

    def revealed?
      @revealed
    end

  def display
    if revealed? && bombed?
      "💣".colorize(:red)
    elsif revealed?
      "_".colorize(:black)
    else
      "*".colorize(:black)
    end
  end
  end
end

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

module Game
  class State

    def play(tiles)
      system 'clear'
      render(tiles)
      # play(tiles) unless finished?(tiles)
    end

    def render(tiles)
      tiles.each_with_index do |row, row_index|
        print "#{row_index} "
        row.each do |tile|
          print "#{tile.display} ".colorize(:background => :white)
        end
        print "\n"
      end
    end

    def finished?(tiles)
      won?(tiles) || lost?(tiles)
    end

    def won?(tiles)
      return false if lost?(tiles.flatten)
      tiles.flatten.all? { |tile| tile.revealed? && !tile.bombed? }
    end

    def lost?(tiles)
      tiles.any? { |tile| tile.bombed? && tile.revealed? }
    end
  end
end

game_properties = Game::Properties.new(difficulty: 'easy')
game_tiles = Game::Board.new.create_tiles(rows: game_properties.rows, columns: game_properties.columns)

game = Game::State.new
game.play(game_tiles)

