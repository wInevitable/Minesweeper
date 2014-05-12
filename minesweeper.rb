require_relative "tile"
require_relative "board"
require "yaml"

class Minesweeper
  def initialize(width = 9, height = 9, bombs = 10)
    self.width, self.height = width, height
    self.bombs = bombs
    self.board = Board.new(width, height, bombs)
  end

  def load(file)
      
  end
  
  def save(file)
    File.open(file, 'w') do |file|
      file.write(self.board.to_yaml)
    end
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
      arg = move[1..-1]
      if action != "s"
        coordinates = arg.split(",")
        coordinates.map! {|el| Integer(el)}
      end
    
      case action
      when "r"
        self.board.reveal(*coordinates)
      when "f"
        self.board.flag(*coordinates)
      when "s"
        self.save(arg)
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