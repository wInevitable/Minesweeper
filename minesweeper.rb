require_relative "tile"

class Minesweeper
  def initialize(width = 9, height = 9, bombs = 10)
    self.board = generate_board(width, height, bombs)
    self.width, self.height = width, height
    self.bombs = bombs
  end
  
  def play
    until over?
      render_board
      player_move
    end
  end
  
  protected
  attr_accessor :board, :bombs, :width, :height
  
  def revealed
    self.board.inject(0) do |sum, row|
      sum + row.select { |el| el.revealed? }.count
    end
  end
  
  def over?
    bomb_revealed = self.board.any? do |row|
      row.any? do |tile|
        tile.bomb? && tile.revealed?
      end
    end

    bomb_revealed || (width * height - bombs) == revealed
  end
  
  def won?
    
  end
  
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
      row.each_index do |j|
        row[j] = tile_pool.shift
      end
    end
  end
  
  def render_board
    board.each do |row|
      row.each_index do |j|
        if row[j].revealed?
          print row[j].bomb_count
        elsif row[j].flag?
          print "?"
        else
          print "#"
        end
      end
      print "\n"
    end
  end
  
  def flag(x, y)
    self.board[x][y].flag = true
  end
  
  def reveal(x, y)
    self.board[x][y].revealed = true
  end
  
  def player_move
    begin
      move = gets.chomp
      action = move[0]
      coordinates = move[1..-1]
      coordinates = coordinates.split(",")
    
      case action
      when "r"
        reveal(*coordinates)
      when "f"
        flag(*coordinates)
      else
        raise "That is not an action."
      end
    rescue Exception => e
      e.message
      retry
    end
  end
end