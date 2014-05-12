class Tile
  attr_writer :bomb, :flag
  
  def initialize(bomb = false, flag = false)
    @bomb, @flag = bomb, flag
  end
  
  def bomb?
    @bomb
  end
  
  def flag?
    @flag
  end
  
  
end