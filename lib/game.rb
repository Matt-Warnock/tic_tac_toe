# frozen_string_literal: true

class Game
  attr_reader :grid

  def initialize
    @grid = []
  end

  def play_turn(player_id, coordinate)
    index = coordinate - 1
    return unless @grid[index].nil?

    @grid[index] = player_id
  end
end
