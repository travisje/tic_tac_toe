require 'pry'
require_relative 'gameboard'
require_relative 'player'

class TicTacToe
  attr_accessor :gameboard, :human, :computer, :win, :current_player
  
  def initialize
    @gameboard = Gameboard.new
    @win = false
    @human = Player.new(@gameboard, "human", 'X')
    @computer = Player.new(@gameboard, "computer", 'O')
    @current_player = human
  end

  def turn_msg
    puts "Would you like to go first or second? Please enter 1 or 2:"
    turn = gets.strip.to_i
  end

  def welcome
    puts '  _______ _        _______           _______         '
    puts ' |__   __(_)      |__   __|         |__   __|        '
    puts '    | |   _  ___     | | __ _  ___     | | ___   ____'
    puts '    | |  | |/ __|    | |/ _` |/ __|    | |/ _ \ / __/'
    puts '    | |  | | (__     | | (_| | (__     | | (_) |  __/'
    puts '    |_|  |_|\___|    |_|\__,_|\___|    |_|\___/ \___|'
    puts '                                                     '
    puts '                             All rights reserved 2015'
    puts '                                                     '
  end

  def randomize_turn
    if rand(1..2) == 1
      @current_player = computer
    end
  end
  
  def player_move
    @current_player.move
    if gameboard.win?
      self.win = true
    else
      if @current_player == human
        @current_player = computer
      else @current_player = human
      end
    end
  end

  def win_message
    puts "The #{current_player.type.capitalize} Wins!"
  end

  def play
    welcome
    randomize_turn
    gameboard.display
    until (win == true) || (gameboard.empty_spaces.length == 0)
      player_move
      gameboard.display
    end
    if win
      win_message
    else 
      puts "It's a draw! Better get out them six shooters."
    end
  end

end


game = TicTacToe.new
game.play
response = 'Y'
until response == 'N'
  puts "Would you like to play again? Please enter Y or N:"
  response = gets.strip.upcase
  if response == 'Y'
    game = TicTacToe.new
    game.play
  end
end