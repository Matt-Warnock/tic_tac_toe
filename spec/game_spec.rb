# frozen_string_literal: true

require 'game'

RSpec.describe Game do
  describe '#play_turn' do
    it 'records a game turn' do
      expect { subject.play_turn(:x, 1) }
        .to change { subject.grid[0] }
        .from(nil).to(:x)
    end
  end
end
