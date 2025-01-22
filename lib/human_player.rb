class HumanPlayer
  def initialize
    puts "Good greetings player, who are you?"
    @name = gets.chomp
  end

  attr_reader :name

  def generate_code
    puts "Alright #{name}, create a four-letter code using any combination of these colours:"
    puts '(Y)ellow, (R)ed, (M)agenta, (B)lue, (G)reen, (P)urple'
    print '=> '
    
    allowed_colours = ['Y', 'R', 'M', 'B', 'G', 'P']
    code = gets.chomp.upcase.split('')
    
    is_valid_code = code.all? { |colour| allowed_colours.include?(colour) } && code.length == 4
    
    until (is_valid_code)
      puts 'Invalid code! Please try again:'
      print '=> '
      code = gets.chomp.upcase.split('')

      is_valid_code = code.all? { |colour| allowed_colours.include?(colour) } && code.length == 4
    end
    code
  end
end

puts HumanPlayer.new.generate_code