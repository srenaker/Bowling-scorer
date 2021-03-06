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
      @rolls = [10] if (@rolls[0] == 10)
      @rolls = [@rolls[0], @rolls[1]] if rolls.size > 2
    end
    
    nil
  end
  
  def rolls
    @rolls
  end
  
  def index
    @index
  end
  
  def total
    rolls.inject(0) { |x,n| x+n }
  end

  def strike?
    rolls[0] == 10
  end
  
  def spare?
    total == 10 && !strike?
  end
  
  def score_with_two_strikes
    if (index < 10)
      ((rolls[0] * 3) + (rolls[1] ? rolls[1] * 2 : 0))
    else
      ((rolls[0] * 3) + (rolls[1] * 2) + rolls[2])  
    end
  end
end
