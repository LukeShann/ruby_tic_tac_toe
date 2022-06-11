class Board
  attr_reader :state

  def initialize
    @state = Array.new(3) { Array.new(3, ' ') }
  end

  def make_move(coords, player)
    self.state[coords[0]][coords[1]] = player
  end

  def has_won?()
    board = self.state
    winning_combinations = [
      [[0, 0], [1, 0], [2, 0]],
      [[0, 1], [1, 1], [2, 1]],
      [[0, 2], [1, 2], [2, 2]],
      [[0, 0], [0, 1], [0, 2]],
      [[1, 0], [1, 1], [1, 2]],
      [[2, 0], [2, 1], [2, 2]],
      [[0, 0], [1, 1], [2, 2]],
      [[2, 0], [1, 1], [0, 2]],
    ]
    winning_combinations.any? do | arr |
      board[arr[0][0]][arr[0][1]] != ' ' && board[arr[0][0]][arr[0][1]] == board[arr[1][0]][arr[1][1]] && board[arr[1][0]][arr[1][1]] == board[arr[2][0]][arr[2][1]]
    end
  end

  def move_valid?(coords)
    self.state[coords[0]][coords[1]] == ' '
  end
end
