# frozen_string_literal: true

class Game
  attr_reader :grid

  def initialize
    @grid = []
    @row_coordinates = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8],
      [0, 3, 6], [1, 4, 7], [2, 5, 8],
      [0, 4, 8], [2, 4, 6]
    ]
  end

  def play_turn(player_id, coordinate)
    validate_play(coordinate)

    @grid[coordinate - 1] = player_id
  end

  def evaluate_game_state
    won_rows = @row_coordinates.select do |coordinate|
      row = [@grid[coordinate[0]], @grid[coordinate[1]], @grid[coordinate[2]]]
      next if row.any?(&:nil?)

      row.uniq.length == 1
    end

    won_rows.flatten
  end

  private

  def validate_play(coordinate)
    raise 'Invalid position' unless (1..9).include?(coordinate)
    raise 'Position already taken' unless @grid[coordinate - 1].nil?
  end
end
