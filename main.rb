# frozen_string_literal: true

require_relative 'lib/constants'
require_relative 'lib/human_player'
require_relative 'lib/computer_player'
require_relative 'lib/game'

print "Welcome to Mastermind!\n\n"
print 'In this game, one player creates a code and the '
print "other player must guess based on the feedback given.\n"
print "Would you like to be the code giver or code guesser? (giver/guesser)\n=> "

human_player_role = gets.chomp

until %w[giver guesser x].include?(human_player_role)
  print "\nInvalid role. Please type either 'giver' or 'guesser', or 'x' to quit.\n=> "
  human_player_role = gets.chomp
end

if human_player_role == 'giver'
  MastermindGame.new(HumanPlayer, ComputerPlayer).play
elsif human_player_role == 'guesser'
  MastermindGame.new(ComputerPlayer, HumanPlayer).play
else
  puts "\nYou have exited the game. Goodbye traveler!"
end
