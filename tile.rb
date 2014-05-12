class Tile
  attr_writer :bomb, :flag
  
  attr_accessor :bomb_count
  
  def initialize(bomb = false, flag = false, bomb_count = 0)
    @bomb, @flag, @bomb_count = bomb, flag, bomb_count
  end

  def bomb?
    @bomb
  end
  
  def flag?
    @flag
  end
end