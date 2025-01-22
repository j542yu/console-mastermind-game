# frozen_string_literal: true

# remove after
require_relative 'constants'

# Allows a computer to play with a human in Mastermind
#
# This class handles both generating the code and guessing
# the code depending on what role the human wants to play
class ComputerPlayer
  include AllowedColours

  def generate_code
    ALLOWED_COLOURS.sample(4)
  end

  def give_feedback(code_given, guess)
    black_pegs = 0
    white_pegs = 0

    guess.each_with_index do |colour, idx|
      if code_given[idx] == colour
        black_pegs += 1
      elsif code_given.include?(colour)
        white_pegs += 1
      end
    end

    [black_pegs, white_pegs]
  end
end
