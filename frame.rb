class Frame
  
  def initialize(rolls, index)
    @rolls = rolls
    @index = index  
  end

  def validate
    # disallow rolls > 10
    @rolls[0] = 10 if (@rolls[0] > 10) 
    @rolls[1] = 10 if (@rolls[1] > 10)
    if (@index == 10)
      @rolls[2] = 10 if (@rolls[2] > 10)
    end

    # if first roll is a strike, discount 2nd roll, unless it's the 10th @rolls
    if (@index < 10)
      @rolls[1] = 0 if (@rolls[0] == 10)
    end
    
    @rolls
  end
  
  
end