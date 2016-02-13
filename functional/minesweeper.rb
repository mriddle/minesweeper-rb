#!/usr/bin/env ruby

require 'yaml'
require 'pry'
require 'colorize'
require 'io/console'

require_relative 'game/properties'
require_relative 'game/tile'
require_relative 'game/board'
require_relative 'game/input'
require_relative 'game/state'

board = Game::Board.new
tiles = board.create_tiles(rows: Game::Properties.rows, columns: Game::Properties.columns)
tiles_with_bombs = board.add_bombs(tiles: tiles, bomb_count: Game::Properties.bomb_count)
game = Game::State.new
game.play(tiles_with_bombs, [0,0])

