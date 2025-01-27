# frozen_string_literal: true

# Represents human player in Mastermind game
#
# This class handles taking human input
# The player either creates a code and gives feedback on guesses as
# a code giver, or guesses code until 12 turns have been exhausted
class HumanPlayer
  include GameConstants

  def initialize
    puts "\n#{Rainbow('Good greetings player, who are you?').white.bg(:darkblue)}"
    print '=> '
    @name = gets.chomp
  end

  attr_reader :name

  def generate_code
    puts "\n#{Rainbow("Alright #{name}, create a four-letter code using any combination of these colours!")
      .white.bg(:darkblue)}\n"

    ask_for_colour_input
  end

  def make_guess
    puts "\nMake your guess!"
    ask_for_colour_input
  end

  def ask_for_colour_input
    loop do
      puts COLOURS_DISPLAY
      print '=> '
      code = gets.chomp.upcase.split('')

      is_valid_code = code.all? { |colour| COLOURS.include?(colour) } && code.length == 4
      return code if is_valid_code

      puts "\n#{Rainbow('Invalid input. Your input must be four letters long and only include the given colours.')
        .white.bg(:red)}"
      puts 'Try again:'
    end
  end

  def give_feedback(code_given) # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
    puts Rainbow("Your secret code is #{code_given.join}").green

    puts 'For every letter (colour) that is in the right position, place down a black peg.'
    puts Rainbow('How many black pegs will you place?').white.bg(:darkblue)
    black_pegs = ask_for_num_input

    puts "For any #{Rainbow('other').bright} letter (colour) that is somewhere in the secret code " \
    'but not in the right position, place down a white peg.'
    puts Rainbow('How many white pegs will you place?').white.bg(:darkblue)
    white_pegs = ask_for_num_input

    while black_pegs + white_pegs > 4
      puts "\n#{Rainbow('Hmm...There are at most 4 pegs in total. Please check your feedback and try again!')
        .white.bg(:red)}"
      black_pegs = ask_for_num_input
      white_pegs = ask_for_num_input
    end

    [black_pegs, white_pegs]
  end

  def ask_for_num_input
    loop do
      print '=> '
      input = gets.chomp
      return input.to_i if input != '' && %(0 1 2 3 4).include?(input)

      puts "\n#{Rainbow('Invalid feedback. Please enter an integer from 0 to 4').white.bg(:red)}"
    end
  end

  def to_s
    name
  end
end
