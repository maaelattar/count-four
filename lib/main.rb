require_relative 'count_four'

puts "\nWelcome to count four game\n"
puts "\nWhat is player1 name?\n"
name1 = gets.chomp
puts "\nWhat is player2 name?\n"
name2 = gets.chomp

game = Game.new(name1, name2)

game.print_board
game.play
