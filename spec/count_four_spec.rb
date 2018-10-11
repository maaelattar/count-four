require 'count_four'

describe Game do
  let(:game) { Game.new('Ali', 'Khaled') }

  describe '#next_player' do
    it 'Picks next player turn' do
      game.next_player
      expect(game.current_player).to eql(game.player2)
      game.next_player
      expect(game.current_player).to eql(game.player1)
    end
  end

  describe '#put_symbol' do
    it 'Puts player symbol into board' do
      id = game.rows_hash['1']
      game.put_symbol('1')
      expect(game.board[id][0]).to eql('x')
    end
  end

  describe '#check_winner' do
    it 'Returns true if there is a match in any row' do
      0.upto(3) do |x|
        game.board[0, x] = 'x'
      end
      expect(game.check_horizontal).to be true
      expect(game.check_winner).to be true
    end

    it 'Returns true if there is a match in any column' do
      0.upto(3) do |y|
        game.board[y, 0] = 'x'
      end
      expect(game.check_vertical).to be true
      expect(game.check_winner).to be true
    end
   end

     describe '#draw?' do
       it 'Checks if there is no winner' do
         expect(game.draw?).to be false
         game.current_turn = 41
         expect(game.draw?).to be true
       end
     end

  end
