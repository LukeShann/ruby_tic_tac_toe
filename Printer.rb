class Printer
  @@frame_width = 60
  @@board_width = 14

  def self.print_board(board)
    print "\n"
    self.print_centered('    1    2    3', ' ')
    print "\n"
    ['A', 'B', 'C'].each_with_index do |label, x|
      self.print_centered("#{label}  #{board[0][x]} | #{board[1][x]} | #{board[2][x]}", ' ')
      break if x > 1
      self.print_centered('    ----------', ' ')
    end
    print "\n"
  end

  def self.print_message(content)
    self.print_centered(content, '=')
  end

  def self.print_centered(content, filler)
    margin = (@@frame_width - content.length) / 2 - 1
    margin.times { print filler }
    print " #{content} "
    (margin + content.length % 2).times { print filler }
    print "\n"
  end
end