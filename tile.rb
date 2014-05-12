class Tile
  attr_writer :bomb, :flag, :revealed
  
  attr_accessor :neighbors
  
  def initialize(bomb = false, flag = false)
    @bomb, @flag = bomb, flag
    @revealed = false
    @neighbors = []
  end

  def bomb?
    @bomb
  end
  
  def flag?
    @flag
  end
  
  def revealed?
    @revealed
  end
  
  def bomb_count
    bomb_count = 0
    @neighbors.each do |neigh|
       bomb_count += 1 if neigh.bomb?
     end
     bomb_count
  end
end