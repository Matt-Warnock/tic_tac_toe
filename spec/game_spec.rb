# frozen_string_literal: true

require 'game'

RSpec.describe Game do
  describe '#play_turn' do
    it 'records a game turn' do
      expect { subject.play_turn(:x, 1) }
        .to change { subject.grid[0] }
        .from(nil).to(:x)
    end

    it 'raises error if existing game turn on coordinate' do
      game = described_class.new
      game.play_turn(:x, 1)

      expect { game.play_turn(:o, 1) }
        .to raise_error('Position already taken')
    end

    it 'raises error if invalid coordinate too low' do
      expect { subject.play_turn(:o, 0) }
        .to raise_error('Invalid position')
    end

    it 'raises error if invalid coordinate too high' do
      expect { subject.play_turn(:o, 10) }
        .to raise_error('Invalid position')
    end
  end

  describe '#evaluate_game_state' do
    it 'confirms first row win' do
      game = described_class.new
      game.play_turn(:x, 1)
      game.play_turn(:x, 2)
      game.play_turn(:x, 3)

      expect(game.evaluate_game_state).to eq([0, 1, 2])
    end

    it 'confirms second row win' do
      game = described_class.new
      game.play_turn(:x, 4)
      game.play_turn(:x, 5)
      game.play_turn(:x, 6)

      expect(game.evaluate_game_state).to eq([3, 4, 5])
    end

    it 'returns empty array if no win evaluated' do
      game = described_class.new

      expect(game.evaluate_game_state).to eq([])
    end
  end
end
