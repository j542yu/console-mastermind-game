# frozen_string_literal: true

# Allows a computer to play with a human in Mastermind
#
# This class handles both generating the code and guessing
# the code depending on what role the human wants to play
class ComputerPlayer
  include AllowedColours

  def initialize
    @previous_guess = nil
    @previous_guess_feedback = nil
    @possible_codes = AllowedColours::ALLOWED_COLOURS.repeated_permutation(4).to_a
  end

  def generate_code
    AllowedColours::ALLOWED_COLOURS.sample(4)
  end

  def give_feedback(correct_code, guess)
    black_pegs = 0
    white_pegs = 0

    guess.each_with_index do |colour, idx|
      if correct_code[idx] == colour
        black_pegs += 1
      elsif correct_code.include?(colour)
        white_pegs += 1
      end
    end

    [black_pegs, white_pegs]
  end

  # uses Donald Knuth's algorithm
  def make_guess
    is_first_guess = @previous_guess.nil?

    if is_first_guess
      @previous_guess = [
        AllowedColours::ALLOWED_COLOURS[0], AllowedColours::ALLOWED_COLOURS[0],
        AllowedColours::ALLOWED_COLOURS[1], AllowedColours::ALLOWED_COLOURS[1]
      ]
    else
      remove_impossible_codes
      # find_best_guess
    end
  end

  def store_feedback(pegs)
    @previous_guess_feedback = pegs
  end

  def remove_impossible_codes
    actual_black_pegs = @previous_guess_feedback[0]
    actual_white_pegs = @previous_guess_feedback[1]

    @possible_codes.each do |possibility|
      possible_pegs = give_feedback(possibility, @previous_guess)
      possible_black_pegs = possible_pegs[0]
      possible_white_pegs = possible_pegs[1]

      unless actual_black_pegs == possible_black_pegs && actual_white_pegs == possible_white_pegs
        @possible_codes.delete(possibility)
      end
    end
  end

  def to_s
    'the computer'
  end
end
