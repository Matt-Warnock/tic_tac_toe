# frozen_string_literal: true

require 'game'

RSpec.describe Game do
  describe '#play_turn' do
    it 'records a game turn' do
      expect { subject.play_turn(:x, 0) }
        .to change { subject.grid[0] }
        .from(nil).to(:x)
    end

    it 'adds a game turn to the counter' do
      expect { subject.play_turn(:x, 0) }
        .to change { subject.instance_variable_get(:@move_counter) }
        .from(0).to(1)
    end

    it 'raises error if existing game turn on coordinate' do
      game = described_class.new
      game.play_turn(:x, 0)

      expect { game.play_turn(:o, 0) }
        .to raise_error('Position already taken')
    end

    it 'raises error if invalid coordinate too low' do
      expect { subject.play_turn(:o, -1) }
        .to raise_error('Invalid position')
    end

    it 'raises error if invalid coordinate too high' do
      expect { subject.play_turn(:o, 9) }
        .to raise_error('Invalid position')
    end
  end

  describe '#evaluate_game_state' do
    context 'when game win' do
      it 'returns winning row' do
        game = described_class.new
        game.play_turn(:x, 0)
        game.play_turn(:x, 1)
        game.play_turn(:x, 2)

        winning_coordinates = [0, 1, 2]
        result = game.evaluate_game_state

        expect(result[:winning_row]).to eq(winning_coordinates)
      end

      it 'game end returns as true' do
        game = described_class.new
        game.play_turn(:x, 0)
        game.play_turn(:x, 1)
        game.play_turn(:x, 2)

        result = game.evaluate_game_state

        expect(result[:game_end]).to eq(true)
      end
    end

    context 'when no win evaluated' do
      it 'returns empty winning_row array' do
        game = described_class.new

        result = game.evaluate_game_state

        expect(result[:winning_row]).to eq([])
      end

      it 'game end returns as false' do
        game = described_class.new

        result = game.evaluate_game_state

        expect(result[:game_end]).to eq(false)
      end
    end

    context 'when all moves have played with no win' do
      it 'returns empty winning_row array' do
        game = described_class.new
        drawing_game(game)

        result = game.evaluate_game_state

        expect(result[:winning_row]).to eq([])
      end

      it 'game end returns as true' do
        game = described_class.new
        drawing_game(game)

        result = game.evaluate_game_state

        expect(result[:game_end]).to eq(true)
      end

      def drawing_game(game)
        game.play_turn(:x, 0)
        game.play_turn(:o, 1)
        game.play_turn(:x, 3)
        game.play_turn(:o, 6)
        game.play_turn(:x, 7)
        game.play_turn(:o, 4)
        game.play_turn(:x, 2)
        game.play_turn(:o, 5)
        game.play_turn(:x, 8)
      end
    end

    it 'confirms second row win' do
      game = described_class.new
      game.play_turn(:x, 3)
      game.play_turn(:x, 4)
      game.play_turn(:x, 5)

      result = game.evaluate_game_state

      expect(result[:winning_row]).to eq([3, 4, 5])
    end

    it 'confirms column win' do
      game = described_class.new
      game.play_turn(:x, 1)
      game.play_turn(:x, 4)
      game.play_turn(:x, 7)

      result = game.evaluate_game_state

      expect(result[:winning_row]).to eq([1, 4, 7])
    end

    it 'confirms diagnal win' do
      game = described_class.new
      game.play_turn(:x, 2)
      game.play_turn(:x, 4)
      game.play_turn(:x, 6)

      result = game.evaluate_game_state

      expect(result[:winning_row]).to eq([2, 4, 6])
    end

    it 'does not confirm win in populated with 2 of the same' do
      game = described_class.new
      game.play_turn(:o, 3)
      game.play_turn(:x, 4)
      game.play_turn(:x, 5)

      result = game.evaluate_game_state

      expect(result[:winning_row]).to eq([])
    end
  end
end
