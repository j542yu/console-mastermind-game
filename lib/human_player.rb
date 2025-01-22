# frozen_string_literal: true

# Represents human player in Mastermind game
#
# This class handles taking human input
# The player either creates a code and gives feedback on guesses as
# a code giver, or guesses code until 12 turns have been exhausted
class HumanPlayer
  include AllowedColours

  def initialize
    puts 'Good greetings player, who are you?'
    @name = gets.chomp
  end

  attr_reader :name

  def generate_code
    puts "\nAlright #{name}, create a four-letter code using any combination of these colours:
      #{AllowedColours::ALLOWED_COLOURS_FULL.join(', ')}\n"

    ask_for_input
  end

  def make_guess
    puts "\nMake your guess!"
    ask_for_input
  end

  def ask_for_input
    loop do
      print '=> '
      code = gets.chomp.upcase.split('')

      is_valid_code = code.all? { |colour| AllowedColours::ALLOWED_COLOURS.include?(colour) } && code.length == 4
      return code if is_valid_code

      puts "\nInvalid input Your input must be four letters long and only include the given colours.\nTry again:"
    end
  end

  def to_s
    name
  end
end
