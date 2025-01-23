# Mastermind Game
Note: This is created as part of The Odin Project's Ruby on Rails path.

## Setting up Ruby
This game is made to play on the console, and is written for Ruby version 3.3.5

## How to Play
The instructions will appear in the console to lead you through the game.
Mastermind is a game where one player creates a four-letter code from six possible letters
(which stand for different colours used in the physical game). The other player must then guess the
correct code in a certain number of tries based on the feedback given.
* Each 'black peg' means a correct letter is in the correct position
* Each 'white peg' means a letter is somewhere in the code, but the position is wrong
* At most four 'pegs' are given for each attempted guess

## Computer Logic
If you choose to create the secret code, the computer can guess your code in an average of
five guesses using the Swaszek algorithm. Pretty cool, eh!