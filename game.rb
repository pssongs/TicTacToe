class Game

  def initialize(p1, p2)
    @p1 = p1
    @p2 = p2
    @game_finished = false
    @board_positions = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  def play
    turn = 0
    until @game_finished
      print_board

      p "Input a number corresponding to the spot Player #{turn % 2 + 1}"
      num = gets.to_i.to_s.match(/\d+/)[0].to_i

      unless @board_positions.include?(num)
        puts "Error. Try Again. Player #{turn % 2 + 1}"
        next
      end

      if turn.even?
        @board_positions.map! { |x| x == num ? 'O' : x }
        @p1.positions.push(num)
        turn += 1
      else
        @board_positions.map! { |x| x == num ? 'X' : x }
        @p2.positions.push(num)
        turn += 1
      end

      check_finished
    end
  end

  def check_finished
    winning_combinations = [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9],
      [1, 4, 7],
      [2, 5, 8],
      [3, 6, 9],
      [1, 5, 9],
      [3, 5, 7]
    ]
    @p1.positions.sort.combination(3).to_a.each do |x|
      if winning_combinations.include?(x)
        (@game_finished = true
         puts 'Congrats Player 1!'
         print_board)
      end
    end
    @p2.positions.sort.combination(3).to_a.each do |x|
      if winning_combinations.include?(x)
        (@game_finished = true
         puts 'Congrats Player 2!'
         print_board)
      end
    end
  end

  def print_board
    @board_positions.each_slice(3).each do |x|
      puts x.each { |p| p }.join(' ')
    end
  end
end
