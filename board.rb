class Board
  def initialize(width, height, bombs)
    @width, @height, @bombs = width, height, bombs
    self.board = Array.new(@height) {|index| [nil] * @width}
  end
  
  def generate    
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
        self.board[row][col] = tile_pool.shift
      end
    end
    
    @board.each_index do |row|
      @board[row].each_index do |col|
        self.board[row][col].neighbors = get_neighbors(row, col)
      end
    end
    
    nil
  end
    
  def render(render_bombs = false)
    print "    |"
    @board[0].each_index do |i|
      print "#{i}".rjust(3, " ")
    end
    
    puts
    puts "-" * (@width * 3 + 5)
    
    @board.each_index do |row|
      index = "#{row}".rjust(3, " ")
      print "#{index} | "
      @board[row].each_index do |j|
        tile = @board[row][j]
        if render_bombs && tile.bomb?
          print " * "
        else
          print " #{tile} "
        end
      end
      print "\n"
    end
    
    nil
  end
  
  def flag(row, col)
    self.board[row][col].flag = true
    
    nil
  end
  
  def reveal(row, col)
    tile = self.board[row][col]
    queue = [tile]
    seen_tiles = []
    
    until queue.empty?
      this_tile = queue.shift
      this_tile.revealed = true
      seen_tiles << this_tile
      
      if this_tile.bomb_count == 0
        new_tiles = this_tile.neighbors
        new_tiles.select! { |t| !seen_tiles.include?(t) }
        new_tiles.select! { |t| !t.flag? }
        queue += new_tiles
      end
    end
    
    nil
  end
  
  def bomb_revealed
    self.board.any? do |row|
      row.any? do |tile|
        tile.bomb? && tile.revealed?
      end
    end
  end
  
  def revealed
    self.board.inject(0) do |sum, row|
      sum + row.select { |el| el.revealed? }.count
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
  
  def get_neighbors(row, col)
    positions = DELTAS.map { |r, c| [row + r, col + c] }
    positions.select! { |r, c| r >= 0 && c >= 0 && r < height && c < width }
 
    neighbors = []
    positions.each do |pos|
      neighbors << self.board[pos[0]][pos[1]]
    end
    
    neighbors
  end
end