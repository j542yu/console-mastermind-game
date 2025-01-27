# Mastermind Game

This is a command line implementation of the classic code-guessing game :)

Note: This is created as part of The Odin Project's Ruby course in their Ruby on Rails path.

## **Setting Up the Game**

This implementation is written in Ruby (version 3.3.5).

### **Running Locally**
1. **Install Ruby**: Follow the official installation guide [here](https://www.ruby-lang.org/en/documentation/installation/).
2. **Clone the Repository**:
   - [Fork](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/working-with-forks/fork-a-repo) this repository.
   - [Clone](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository) your forked repo to your local machine.
3. **Install Dependencies**:
   - Open a terminal and navigate to the project directory.
   - Run `bundle install` to install the required gems, including the _rainbow_ gem for colorful text output.
4. **Start the Game**:
   - Run `ruby main.rb` to launch the game and follow the on-screen instructions.

### **Running Remotely**
Use a remote environment like [Replit.com](https://replit.com) by uploading the project files and running `ruby main.rb`.

## **How to Play**

Mastermind is a classic code-breaking game where one player creates a secret code, and the other player tries to guess it within a limited number of attempts.

### **Game Rules**
1. The **codemaker** creates a secret four-letter code using six possible letters (each representing a color in the physical game).
2. The **codebreaker** has a set number of attempts to guess the code.
3. After each guess, the codemaker provides feedback:
   - **Black Pegs**: Correct letter in the correct position.
   - **White Pegs**: Correct letter but in the wrong position.
4. The codebreaker uses this feedback to refine their guesses and crack the code.

When you run the game, follow the on-screen instructions which will guide you through.

## **Computer Logic**

If you choose to be the codemaker, the computer will use the Swaszek algorithm to guess your secret code in an average of five guesses. Pretty cool, eh?