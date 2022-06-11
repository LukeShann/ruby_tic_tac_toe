require_relative "Board"

class Game
  attr_accessor :board, :turn, :turns_taken
  attr_reader :messages

  def initialize
    @board = Board.new
    @turn = 'O'
    @turns_taken = 0

    self.play_game
  end

  def play_game
    puts "Welcome to Tic Tac Toe!\nGet three in a row to win!\nEnter the co-ordinates to play (e.g. 1A)"
    loop do
      self.take_turn
      if board.has_won? then
        self.board.print_board
        puts "=========== #{self.turn} Wins! ==========="
        self.ask_for_reset
        break
      elsif self.turns_taken >= 9 then
        self.board.print_board
        puts "=========== Stale Mate! ==========="
        self.ask_for_reset
      else
        self.turn = self.turn == 'X' ? 'O' : 'X'
      end
    end
  end

  def ask_for_reset
    puts "==== Press any key to reset ==="
    gets
    self.reset
  end

  def reset
    self.board = Board.new
    self.play_game
    self.turns_taken = 0
  end

  def take_turn
    self.board.print_board
    puts "=== It's #{self.turn}'s turn to play ==="
    move = []
    loop do
      move = get_coords
      break if self.board.move_valid?(move)
    end
    self.board.make_move(move, self.turn)
    self.turns_taken += 1
  end

  def get_coords
    coords = nil
    puts "Enter co-ordinates: "
    loop do
      coords = gets.chomp.upcase
      break if input_valid?(coords)
      puts "Enter valid co-ordinates (e.g 1A):"
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
