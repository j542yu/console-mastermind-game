# frozen_string_literal: true

require_relative 'lib/constants'
require_relative 'lib/human_player'
require_relative 'lib/computer_player'
require_relative 'lib/game'

Game.new(ComputerPlayer, HumanPlayer).play
