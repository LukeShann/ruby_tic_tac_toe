require_relative "Printer"

class Game
  include Printer
  
  attr_accessor :board, :turn, :turns_taken
  attr_reader :messages

  def initialize
    @board = Board.new
    @turn = 'O'
    @turns_taken = 0

    play_game
  end

  def play_game
    print_message("Welcome to Tic Tac Toe!")
    print_message("Get three in a row to win!")
    print_message("Enter the co-ordinates to play (e.g. 1A)")
    loop do
      take_turn
      if board.has_won? then
        print_board(board.state)
        print_message("#{@turn} Wins!")
        ask_for_reset
        break
      elsif turns_taken >= 9 then
        print_board(board.state)
        print_message("Stale Mate!")
        ask_for_reset
      else
        @turn = @turn == 'X' ? 'O' : 'X'
      end
    end
  end

  def ask_for_reset
    print_message("Press any key to reset")
    gets
    reset
  end

  def reset
    @board = Board.new
    @turns_taken = 0
    play_game
  end

  def take_turn
    print_board(board.state)
    print_message("It's #{turn}'s turn to play")
    move = []
    loop do
      move = get_coords
      break if board.move_valid?(move)
    end
    board.make_move(move, turn)
    @turns_taken += 1
  end

  def get_coords
    coords = nil
    print_message("Enter co-ordinates")
    loop do
      coords = gets.chomp.upcase
      break if input_valid?(coords)
      print_message("Enter valid co-ordinates (e.g 1A)")
    end
    translation = {'A' => 0, 'B' => 1, 'C' => 2}

    [coords[0].to_i - 1, translation[coords[1]]]
  end

  def input_valid?(input)
    return false if input.length != 2
    return false if input[0].to_i < 1 || input[0].to_i > 3
    ['A', 'B', 'C'].include?(input[1])
  end
end
