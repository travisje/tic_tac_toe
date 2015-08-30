class Gameboard
  attr_accessor :gameboard, :winning_combo_coords
  
  def initialize
    @gameboard = []
    3.times do
      @gameboard << [" "," "," "]
    end
    @winning_combo_coords = self.compute_winning_combos
  end

  def display
    puts "  _________________"
    puts " |  1  |  2  |  3  |"
    puts " |  #{gameboard[0][0]}  |  #{gameboard[0][1]}  |  #{gameboard[0][2]}  |"
    puts " |_____|_____|_____|"
    puts " |  4  |  5  |  6  |"
    puts " |  #{gameboard[1][0]}  |  #{gameboard[1][1]}  |  #{gameboard[1][2]}  |"
    puts " |_____|_____|_____|"
    puts " |  7  |  8  |  9  |"
    puts " |  #{gameboard[2][0]}  |  #{gameboard[2][1]}  |  #{gameboard[2][2]}  |"
    puts " |_____|_____|_____|"
    puts "                    "
    puts "                    "
  end

  def compute_winning_combos
    results = [vertical_combo_coords, horizontal_combo_coords, diagonal_combo_coords]
    results.flatten(1)
  end

  def vertical_combo_coords
    results = []
    inner_index = 0
    until inner_index == width
      results << []
      gameboard.each_with_index do |row, outer_index|
        results.last << [outer_index,inner_index]
      end
      inner_index +=1
    end
    results
  end

  def horizontal_combo_coords
    results = []
    gameboard.each_with_index do |row, outer_index|
      results << []
      row.each_with_index do |square, inner_index|
        results.last << [outer_index,inner_index]
      end
    end
    results
  end

  def diagonal_combo_coords
    results = []
    outer_index = 0
    inner_index = 0
    results << []
    width.times do
      results.last << [outer_index, inner_index]
      outer_index += 1
      inner_index +=1
    end
    results << []
    outer_index = 0
    inner_index = width-1
    width.times do
      results.last << [outer_index, inner_index]
      outer_index += 1
      inner_index -= 1
    end
    results
  end

  def output_indiv_combo(combo_coords)
    results = []
    combo_coords.each do |indexes|
      results << gameboard[indexes[0]][indexes[1]]
    end
    results
  end

  def win?
    win = nil
    winning_combo_coords.each do |winning_combo|
      if (output_indiv_combo(winning_combo).count('X') == width) || (output_indiv_combo(winning_combo).count('O') == width)
        win = true
      end
    end
    win
  end

  def spaces_for_win(symbol)
    result_coords = []
    winning_combo_coords.each do |winning_combo|
      if (output_indiv_combo(winning_combo).count(symbol) == (width - 1)) && (output_indiv_combo(winning_combo).count(" ") == 1)
        blank_space_index = output_indiv_combo(winning_combo).index(' ')
        result_coords << winning_combo[blank_space_index]
      end
    end
    result_coords
  end

  def empty_spaces
    results = []
    gameboard.each_with_index do |row, outer_index|
       row.each_with_index do |space, inner_index|
        if space == " "
          results << [outer_index,inner_index]
        end
       end
    end
    results
  end

  def fill_square(indexes, symbol)
    if !indexes.is_a?(Array)
      indexes = space_to_index(indexes)
    end
    gameboard[indexes[0]][indexes[1]] = symbol
  end

  def space_to_index(space)
    [(space-1)/width, (space-1)-((space-1)/width)*width]
  end

  def width
    gameboard.length
  end

  def space_valid?(space)
    valid = false
    num_of_spaces = self.width * 3
    if (space > 0) && (space <= num_of_spaces)
      indexes = self.space_to_index(space)
      if gameboard[indexes[0]][indexes[1]] == " "
        valid = true
      end
    end
    valid
  end

  def moves_avail(index_array)
    results = []
    index_array.each do |square|
      if gameboard[square[0]][square[1]] == " "
        results << square
      end
    end
    results
  end

  def corner_moves_avail
    max_index = width - 1
    corner_indexes = [[0,0],[0,max_index],[max_index,0],[max_index,max_index]]
    moves_avail(corner_indexes)
  end


  def center_move_avail
    results = []
    center_index = 0 + width/2
    moves_avail([[center_index,center_index]])
  end

  def offense_needed?(symbol)
    spaces_for_win(symbol).any?
  end

  def defense_needed?(symbol)
    spaces_for_win(symbol).any?
  end

end