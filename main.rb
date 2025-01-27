# frozen_string_literal: true

require 'rainbow'

require_relative 'lib/constants'
require_relative 'lib/human_player'
require_relative 'lib/computer_player'
require_relative 'lib/game'

puts Rainbow("Welcome to Mastermind!\n").yellow.bright
puts 'In this game, one player creates a code and the ' \
'other player must guess based on the feedback given.'
puts Rainbow('Would you like to (c)reate the code or (g)uess the code? (c/g)').white.bg(:darkblue)
print '=> '

human_player_role = gets.chomp.downcase

until %w[c g x].include?(human_player_role)
  puts "\n#{Rainbow("Invalid role. Please type either 'c' to create, 'g' to guess, or 'x' to quit.")
    .white.bg(:red)}"
  print '=> '
  human_player_role = gets.chomp.downcase
end

if human_player_role == 'c'
  MastermindGame.new(HumanPlayer, ComputerPlayer).play
elsif human_player_role == 'g'
  MastermindGame.new(ComputerPlayer, HumanPlayer).play
else
  puts Rainbow("\nYou have exited the game. Goodbye traveler!").green
end
