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

  def give_feedback(correct_code, guess)
    [count_black_pegs(correct_code, guess), count_white_pegs(correct_code, guess)]
  end

  # one black peg for each exact colour match
  def count_black_pegs(correct_code, guess)
    correct_code.zip(guess).count { |c, g| c == g }
  end

  # one white peg for each colour that is in code but in wrong position
  def count_white_pegs(correct_code, guess) # rubocop:disable Metrics/MethodLength
    remaining_code = filter_remaining_colours(correct_code, guess)
    remaining_guess = filter_remaining_colours(guess, correct_code)

    remaining_guess.sum do |g|
      idx = remaining_code.index(g)

      if idx
        remaining_code.delete_at(idx)
        1
      else
        0
      end
    end
  end

  def filter_remaining_colours(source, target)
    source.each_index.reject { |idx| source[idx] == target[idx] }.map { |idx| source[idx] }
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
