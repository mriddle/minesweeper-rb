class Component
  attr_reader :x, :y, :align, :lines

  def initialize(x: 0, y: 0, align: :left, lines: [])
    @x = x
    @y = y
    @align = align
    @lines = lines
    @dirty = true
  end

  def dirty?
    @dirty
  end

  def mark_dirty
    @dirty = true
  end

  def mark_clean
    @dirty = false
  end
end
