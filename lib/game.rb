# frozen_string_literal: true


class Game

  attr_reader :grid

  def initialize
    @grid = []
  end
  
  def play_turn(player_id, coordinate)
    @grid[coordinate-1] = player_id
  end
end
