class Tile

  attr_accessor :state



  def bombed?
    state == :bombed
  end

  def revealed?
    #state == :revealed
    true
  end

end
