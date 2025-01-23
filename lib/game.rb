# frozen_string_literal: true

# Represents a game of Mastermind
#
# This class orchestrates the flow of the game where one player (the code giver) generates a secret code,
# and the other player (the code guesser) tries to guess it. The game consists of multiple rounds, where
# the code guesser makes a guess and the code giver provides feedback on whether the guess is correct.
#
# The game continues until the code guesser guesses the correct code, or the guesser has exhausted
# the number of max rounds
class MastermindGame
  include GameConstants

  def initialize(code_giver_class, code_guesser_class)
    @code_giver = code_giver_class.new
    @code_guesser = code_guesser_class.new
  end

  attr_reader :code_giver, :code_guesser

  def play # rubocop:disable Metrics/MethodLength
    rounds_played = 0
    black_pegs = 0
    start_game
    correct_code = code_giver.generate_code

    loop do
      rounds_played += 1

      guess = code_guesser.make_guess
      break if guess.nil?

      display_guess(guess, rounds_played)

      pegs = ask_for_feedback(correct_code, guess)
      display_feedback(pegs)

      black_pegs = pegs[0]

      break if black_pegs == 4 || rounds_played == MAX_ROUNDS
    end
    end_game(black_pegs, rounds_played, correct_code)
  end

  def display_guess(guess, rounds_played)
    puts "\nAttempt #{rounds_played}:"
    puts "#{code_guesser.to_s.capitalize} guesses the code is #{guess.join}"
  end

  def ask_for_feedback(correct_code, guess)
    if code_giver.instance_of?(ComputerPlayer)
      code_giver.give_feedback(correct_code, guess)
    else
      code_giver.give_feedback(correct_code)
    end
  end

  def display_feedback(pegs)
    if code_guesser.instance_of?(HumanPlayer)
      display_computer_feedback(pegs)
    else
      code_guesser.store_feedback(pegs)
    end
  end

  def display_computer_feedback(pegs)
    black_pegs = pegs[0]
    white_pegs = pegs[1]
    puts "The computer places down #{black_pegs} black peg(s) and #{white_pegs} white peg(s)"
  end

  def start_game
    print "\nLet's start the game! #{code_giver.to_s.capitalize} will "
    print "create a secret code and #{code_guesser} must "
    puts "guess it in #{MAX_ROUNDS} tries or less :>"
    puts "The available colours are #{COLOURS_FULL.join(', ')}"
  end

  def end_game(black_pegs, rounds_played, correct_code)
    print "\nGame over! "
    if black_pegs == 4
      puts "#{code_guesser.to_s.capitalize} guessed the correct code in #{rounds_played} rounds."
    elsif rounds_played == MAX_ROUNDS
      puts "#{code_guesser.to_s.capitalize} has exhausted all their chances with incorrect guesses."
      puts "The correct code was #{correct_code}..."
    else
      puts "The computer thinks you made a mistake giving feedback... There's no possible correct answer! Byebye :("
    end
  end
end
