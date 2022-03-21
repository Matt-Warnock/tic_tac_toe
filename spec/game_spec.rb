# frozen_string_literal: true

require 'game'

RSpec.describe Game do
  describe '#play_turn' do
    it 'records a game turn' do
      expect { subject.play_turn(:x, 1) }
        .to change { subject.grid[0] }
        .from(nil).to(:x)
    end

    it 'doesnt record over an existing game turn' do
      game = described_class.new
      game.play_turn(:x, 1)

      expect { game.play_turn(:o, 1) }
        .not_to(change { game.grid[0] })
    end
  end
end
