class Minesweeper
  def initialize(width = 9, height = 9, bombs = 10)
    self.board = generate_board(width, height, bombs)
    self.bombs = bombs
  end
  
  def play
    
  end
  
  protected
  attr_accessor :board, :bombs
  
  def generate_board(width, height, bombs)
    board = [[nil] * width] * height
    
    tile_pool = []
    bombs.times do
      tile_pool << Tile.new(true)
    end
    
    (width * height - bombs).times do
      tile_pool << Tile.new
    end
    
    tile_pool.shuffle!
    
    board.each do |row|
      row.each do |j|
        row[j] = tile_pool.shift
      end
    end
  end
  
  def render_board
    board.each do |row|
      row.each do |j|
        if row[j].revealed?
          print row[j].bomb_count
        else
          print "#"
        end
      end
    end
  end
end