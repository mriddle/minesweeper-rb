RSpec.describe Game::Tile do
  let(:position) { double('position') }
  let(:tile)     { described_class.new(position: position, bombed: bombed, revealed: revealed) }

  describe "displaying a tile" do
    context 'when the tile has been revealed' do
      let(:revealed) { true }

      context 'but does not have a bomb' do
        let(:bombed) { false }

        context 'with no neighbouring bombs' do
          let(:neighbouring_bomb_count) { 0 }

          it "returns the revealed tile" do
            expect(tile.display(neighbouring_bomb_count)).to eq " _ "
              .colorize(color: :black, background: :white)
          end
        end

        context 'with neighbouring bombs' do
          it 'displays the count of neighbouring bombs' do
            expect(tile.display(1)).to eq " 1 "
              .colorize(color: :green, background: :white)
            expect(tile.display(2)).to eq " 2 "
              .colorize(color: :blue, background: :white)
            expect(tile.display(3)).to eq " 3 "
              .colorize(color: :magenta, background: :white)
            expect(tile.display(4)).to eq " 4 "
              .colorize(color: :light_red, background: :white)
            expect(tile.display(5)).to eq " 5 "
              .colorize(color: :light_red, background: :white)
          end
        end
      end
    end
  end
end
