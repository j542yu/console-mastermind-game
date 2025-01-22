# frozen_string_literal: true

# Represents a game of Mastermind
#
# This class orchestrates the flow of the game where one player (the code giver) generates a secret code,
# and the other player (the code guesser) tries to guess it. The game consists of multiple rounds, where
# the code guesser makes a guess and the code giver provides feedback on whether the guess is correct.
#
# The game continues until the code guesser guesses the correct code, or the guesser has exhausted
# the number of max rounds
class Game
  include NumberOfRounds
  include AllowedColours

  def initialize(code_giver_class, code_guesser_class)
    @code_giver = code_giver_class.new
    @code_guesser = code_guesser_class.new
  end

  attr_reader :code_giver, :code_guesser

  def play # rubocop:disable Metrics/MethodLength
    rounds_played = 0
    start_game
    code_given = code_giver.generate_code

    loop do
      rounds_played += 1

      guess = code_guesser.make_guess
      display_guess(guess)

      pegs = code_giver.give_feedback(code_given, guess)
      display_feedback(pegs)

      black_pegs = pegs[0]

      if black_pegs == 4 || rounds_played == NumberOfRounds::MAX_ROUNDS
        end_game(black_pegs, rounds_played)
        break
      end
    end
  end

  def display_guess(guess)
    puts "\n#{code_guesser.to_s.capitalize} guesses the code is #{guess.join}"
  end

  def display_feedback(pegs)
    black_pegs = pegs[0]
    white_pegs = pegs[1]
    puts "#{code_giver.to_s.capitalize} places down #{black_pegs} black peg(s) and #{white_pegs} white peg(s)"
  end

  def start_game
    print "\nLet's start the game! #{code_giver.to_s.capitalize} will "
    print "create a secret code and #{code_guesser} must "
    print "guess it in #{NumberOfRounds::MAX_ROUNDS} tries or less :>"
    puts "The available colours are #{AllowedColours::ALLOWED_COLOURS_FULL.join(', ')}"
  end

  def end_game(black_pegs, rounds_played)
    print "\nGame over! "
    if black_pegs == 4
      puts "#{code_guesser.to_s.capitalize} guessed the correct code!"
    elsif rounds_played == NumberOfRounds::MAX_ROUNDS
      puts "#{code_guesser.to_s.capitalize} has exhausted all their chances with incorrect guesses"
    end
  end
end
