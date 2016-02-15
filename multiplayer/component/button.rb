require 'pastel'
require_relative "basic"

module Component
  PASTEL = Pastel.new

  class Button < Basic
    LENGTH = 25
    LIGHT = {
      hor: "─",
      vert: "│",
      top_left: "╭",
      top_right: "╮",
      bottom_left: "╰",
      bottom_right: "╯",
    }

    HEAVY = {
      hor: "━",
      vert: "┃",
      top_left: "┏",
      top_right: "┓",
      bottom_left: "┗",
      bottom_right: "┛",
    }

    def title=(title)
      @title = title
      gap = (LENGTH - title.length).to_f / 2
      @left_spacing = " " * gap.floor
      @right_spacing = " " * gap.ceil

      @lines = build(LIGHT)
      mark_dirty
    end

    def lines
      @lines
    end

    def select
      @lines = build(HEAVY).map { |t| PASTEL.yellow t }
      mark_dirty
    end

    def deselect
      @lines = build(LIGHT)
      mark_dirty
    end

    private

    def build(type)
      [build_top(type), build_middle(type), build_bottom(type)]
    end

    def build_top(type)
      type[:top_left] + type[:hor] * LENGTH + type[:top_right]
    end

    def build_middle(type)
      type[:vert] + @left_spacing + @title + @right_spacing + type[:vert]
    end

    def build_bottom(type)
      type[:bottom_left] + type[:hor] * LENGTH + type[:bottom_right]
    end
  end
end
