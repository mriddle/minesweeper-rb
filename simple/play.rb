#!/usr/bin/env ruby

require_relative 'minesweeper'

tiles = Game::Board.create_tiles(rows: Game::Properties.rows, columns: Game::Properties.columns)
tiles_with_bombs = Game::Board.add_bombs(tiles: tiles, bomb_count: Game::Properties.bomb_count)
game = Game::State.new
game.play(tiles_with_bombs, [0,0])
