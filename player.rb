class Player
  attr_accessor :gameboard,:type, :symbol

  def initialize(gameboard, type, symbol)
    @gameboard = gameboard
    @type = type
    @symbol = symbol
  end

  def move
    if self.type == 'human'
      human_pick
    else computer_pick
    end
  end

  def human_pick
    valid = false
    until valid == true
      puts "Please enter #{symbol}'s move:"
      space = gets.strip.to_i
      if gameboard.space_valid?(space)
        valid = true
      else
        puts "Invalid selection"
      end
    end 
    gameboard.fill_square(space, self.symbol)
  end

  def opponent_symbol
    if self.type == "X"
      "O"
    else "X"
    end
  end

  def computer_pick
    puts "Press Enter to see Computer's move:" 
    proceed = gets.chomp
    if gameboard.center_move_avail.any?
      gameboard.fill_square(gameboard.center_move_avail[0], self.symbol)
    elsif gameboard.offense_needed?(self.symbol)
      gameboard.fill_square(gameboard.spaces_for_win(self.symbol).sample, self.symbol)
    elsif gameboard.defense_needed?(opponent_symbol)
      gameboard.fill_square(gameboard.spaces_for_win(opponent_symbol).sample, self.symbol)
    elsif gameboard.corner_moves_avail.length > 2
      gameboard.fill_square(gameboard.corner_moves_avail.sample, self.symbol)
    else
      gameboard.fill_square(gameboard.empty_spaces.sample, self.symbol)
    end
  end

end