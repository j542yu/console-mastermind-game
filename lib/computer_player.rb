# frozen_string_literal: true

# Allows a computer to play with a human in Mastermind
#
# This class handles both generating the code and guessing
# the code depending on what role the human wants to play
class ComputerPlayer
  include GameConstants

  def initialize
    @previous_guess = nil
    @previous_guess_feedback = nil
    @possible_codes = COLOURS.repeated_permutation(4).to_a
  end

  def generate_code
    COLOURS.sample(4)
  end

  def give_feedback(correct_code, guess) # rubocop:disable Metrics/MethodLength
    black_pegs = 0
    white_pegs = 0
    correct_code_copy = correct_code.dup

    guess.each_with_index do |colour, idx|
      if correct_code_copy[idx] == colour
        black_pegs += 1
        correct_code_copy[idx] = nil
      elsif correct_code_copy.include?(colour)
        white_pegs += 1
      end
    end

    [black_pegs, white_pegs]
  end

  # uses Swaszek algorithm
  def make_guess
    is_first_guess = @previous_guess.nil?

    if is_first_guess
      @previous_guess = [COLOURS[0], COLOURS[0], COLOURS[1], COLOURS[1]]
    else
      remove_impossible_codes
      @previous_guess = @possible_codes[0]
    end
    @possible_codes.delete(@previous_guess) # returns @previous_guess
  end

  def store_feedback(pegs)
    @previous_guess_feedback = pegs
  end

  def remove_impossible_codes
    @possible_codes.select! do |possibility|
      @previous_guess_feedback == give_feedback(possibility, @previous_guess)
    end
  end

  def to_s
    'the computer'
  end
end
