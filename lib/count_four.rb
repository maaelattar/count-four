Player = Struct.new(:name, :symbol)

class Game
  attr_accessor :player1, :player2, :current_player, :board, :rows_hash, :options, :current_turn
  def initialize(player1, player2)
    @player1 = Player.new(player1, 'x')
    @player2 = Player.new(player2, 'o')
    @current_player = @player1
    @board = Array.new(6) { Array.new(7) { ' ' } }
    @rows_hash = { '1' => 5, '2' => 5, '3' => 5,

                   '4' => 5, '5' => 5, '6' => 5, '7' => 5 }
    @options = %w[1 2 3 4 5 6 7]
    @current_turn = 1
  end

  def next_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

  def put_symbol(input)
    id = @rows_hash[input]
    return if id < 0
    @rows_hash[input] -= 1
    @board[id][input.to_i - 1] = @current_player.symbol
    @current_turn += 1
  end

  def print_board
    board = ''
    @board.each do |arr|
      arr.each do |e|
        board += " #{e} |"
      end
      board += "\n"
    end
    puts board
    puts " #{@options.join('---')}"
  end

  def check_winner
    check_horizontal || check_vertical || check_diagonal
  end

  def draw?
    @current_turn == 41
  end

  def game_end?
    draw? || check_winner
  end

  def check_horizontal
    0.upto(5) do |y|
      0.upto(3) do |x|
        return true if @board[y][x] != ' ' &&
                       @board[y][x] == @board[y][x + 1] &&
                       @board[y][x + 1] == @board[y][x + 2] &&
                       @board[y][x + 2] == @board[y][x + 3]
      end
    end
    false
  end

  def check_vertical
    0.upto(6) do |x|
      0.upto(2) do |y|
        return true if @board[y][x] != ' ' &&
                       @board[y][x] == @board[y + 1][x] &&
                       @board[y + 1][x] == @board[y + 2][x] &&
                       @board[y + 2][x] == @board[y + 3][x]
      end
    end

    false
  end

  def check_diagonal
    0.upto(3) do |x|
      0.upto(2) do |y|
        return true if @board[y][x] != ' ' &&
                       @board[y][x] == @board[y + 1][x + 1] &&
                       @board[y + 1][x + 1] == @board[y + 2][x + 2] &&
                       @board[y + 2][x + 2] == @board[y + 3][x + 3]
      end

      3.upto(5) do |y|
        return true if @board[y][x] != ' ' &&
                       @board[y][x] == @board[y - 1][x + 1] &&
                       @board[y - 1][x + 1] == @board[y - 2][x + 2] &&
                       @board[y - 2][x + 2] == @board[y - 3][x + 3]
      end
    end

    false
  end

  def choose_column
    input = gets.chomp
    until @options.include?(input)
      puts 'Wrong choice'
      input = gets.chomp
    end
    input
  end

  def play
    until game_end?
      puts "\nChoose the column you want\n"
      input = choose_column
      put_symbol(input)
      print_board
      next_player
    end
    puts "\nCongratulations #{@current_player.name} is the winner\n" if check_winner
    puts "\nGame over no player won\n" if draw?
  end
end

