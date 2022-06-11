

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
    Printer.print_message("Welcome to Tic Tac Toe!")
    Printer.print_message("Get three in a row to win!")
    Printer.print_message("Enter the co-ordinates to play (e.g. 1A)")
    loop do
      self.take_turn
      if board.has_won? then
        Printer.print_board(self.board.state)
        Printer.print_message("#{self.turn} Wins!")
        self.ask_for_reset
        break
      elsif self.turns_taken >= 9 then
        Printer.print_board(self.board.state)
        Printer.print_message("Stale Mate!")
        self.ask_for_reset
      else
        self.turn = self.turn == 'X' ? 'O' : 'X'
      end
    end
  end

  def ask_for_reset
    Printer.print_message("Press any key to reset")
    gets
    self.reset
  end

  def reset
    self.board = Board.new
    self.turns_taken = 0
    self.play_game
  end

  def take_turn
    Printer.print_board(self.board.state)
    Printer.print_message("It's #{self.turn}'s turn to play")
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
    Printer.print_message("Enter co-ordinates")
    loop do
      coords = gets.chomp.upcase
      break if input_valid?(coords)
      Printer.print_message("Enter valid co-ordinates (e.g 1A)")
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
