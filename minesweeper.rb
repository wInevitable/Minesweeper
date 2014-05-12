class Minesweeper
  def initialize(width = 9, height = 9, bombs = 10)
    self.board = generate_board(width, height, bombs)
    self.bombs = bombs
  end
  
  def play
    
  end
  
  def generate_board(width, height, bombs)
    
  end
  
  protected
  attr_accessor :board, :bombs
  
end