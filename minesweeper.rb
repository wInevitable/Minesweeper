require_relative "tile"

class Minesweeper
  def initialize(width = 9, height = 9, bombs = 10)
    self.width, self.height = width, height
    self.bombs = bombs
  end
  
  def play
    generate_board
       
    until over?
      render_board
      player_move
    end
  end
  
  protected
  attr_accessor :board, :bombs, :width, :height
  
  DELTAS = [
    [1, 0], [-1, 0],
    [0, 1], [0, -1],
    [-1, 1], [1, -1],
    [-1, -1], [1, 1]
  ]
  
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

    bomb_revealed || (@width * @height - @bombs) == revealed
  end
  
  def won?
    
  end
  
  def generate_board
    @board = Array.new(@height) {|index| [nil] * @width}
    
    tile_pool = []
    @bombs.times do
      tile_pool << Tile.new(true)
    end
    
    (@width * @height - @bombs).times do
      tile_pool << Tile.new
    end
    
    tile_pool.shuffle!
    
    @board.each_index do |row|
      @board[row].each_index do |col|
        @board[row][col] = tile_pool.shift
      end
    end
    
    @board.each_index do |row|
      @board[row].each_index do |col|
        @board[row][col].neighbors = get_neighbors(row, col)
      end
    end
  end
  
  def get_neighbors(row, col)
    positions = DELTAS.map { |r, c| [row + r, col + c] }
    positions.select! { |r, c| r >= 0 && c >= 0 && r < height && c < width }
 
    neighbors = []
    positions.each do |pos|
      neighbors << @board[pos[0]][pos[1]]
    end
    
    neighbors
  end
  
  def render_board
    @board.each do |row|
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
      coordinates.map! {|el| Integer(el)}
    
      case action
      when "r"
        reveal(*coordinates)
      when "f"
        flag(*coordinates)
      else
        raise IOError.new("That is not an action.")
      end
    rescue IOError => e
      e.message
      retry
    end
  end
end