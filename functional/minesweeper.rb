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

game_tiles = Game::Board.new.create_tiles(rows: Game::Properties.rows, columns: Game::Properties.columns)

game = Game::State.new
game.play(game_tiles, [0,0])

