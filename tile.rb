class Tile
  attr_writer :bomb, :flag, :revealed
  
  attr_accessor :bomb_count
  
  def initialize(bomb = false, flag = false, bomb_count = 0)
    @bomb, @flag, @bomb_count = bomb, flag, bomb_count
    @revealed = false
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
end