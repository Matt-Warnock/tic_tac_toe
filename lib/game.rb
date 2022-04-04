# frozen_string_literal: true

class Game
  attr_reader :grid

  def initialize
    @grid = []
  end

  def play_turn(player_id, coordinate)
    validate_play(coordinate)

    @grid[coordinate - 1] = player_id
  end

  private

  def validate_play(coordinate)
    raise 'Invalid position' unless (1..9).include?(coordinate)
    raise 'Position already taken' unless @grid[coordinate - 1].nil?
  end
end
