require_relative "tile"
require_relative "board"

class Minesweeper
  def initialize(width = 9, height = 9, bombs = 10)
    self.width, self.height = width, height
    self.bombs = bombs
    self.board = Board.new(width, height, bombs)
  end
  
  def play
    self.board.generate
       
    until over?
      self.board.render
      player_move
    end
    
    self.board.render(true)
    if won?
      puts "You Win!"
    else
      puts "Try Again!"
    end
  end
  
  protected
  attr_accessor :board, :width, :height, :bombs
  
  def over?
    self.board.bomb_revealed ||
    (@width * @height - @bombs) == self.board.revealed
  end
  
  def won?
    !self.board.bomb_revealed
  end
  
  def player_move
    begin
      move = gets.chomp
      action = move[0]
      coordinates = move[1..-1]
      coordinates = coordinates.split(",")
      coordinates.map! {|el| Integer(el)}
    
      case action
      when "r"
        self.board.reveal(*coordinates)
      when "f"
        self.board.flag(*coordinates)
      else
        raise IOError.new("That is not an action.")
      end
    rescue IOError => e
      e.message
      retry
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  Minesweeper.new.play
end