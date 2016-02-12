class Tile
  MOVE = [[0,1],[1,0],[-1,0],[0,-1],[1,1],[-1,-1],[-1,1],[1,-1]]

  attr_accessor :position, :board

  def initialize(position, board)
    @position = position
    @board = board
  end

  def bombed!
    @bombed = true
  end

  def reveal!
    return if revealed?
    @revealed = true
    return if bombed?
    return if neighbor_bomb_count > 0
    neighbours.each(&:reveal!)
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
    elsif revealed? && neighbor_bomb_count == 0
      "_".colorize(:black)
    elsif revealed?
      colourize_numbers(neighbor_bomb_count)
    else
      "*".colorize(:black)
    end
  end

  private

  def colourize_numbers(count)
    case count
    when 3
      return count.to_s.colorize(:magenta)
    when 2
      return count.to_s.colorize(:blue)
    when 1
      return count.to_s.colorize(:green)
    else
      return count.to_s.colorize(:light_red)
    end
  end


  def neighbours
    neighbours_pos = []
    MOVE.each do |move|
      possible_neighbor = [move[0] + position[0] , move[1]+position[1]]
      if possible_neighbor.all? { |cord| cord.between?(0, Game::Properties.boundary) }
        neighbours_pos << possible_neighbor
      end
    end
    neighbours_pos.map {|pos| board[pos] }
  end

  def neighbor_bomb_count
    neighbours.count(&:bombed?)
  end
end
