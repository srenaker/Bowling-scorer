class Frame
  
  def initialize(frame, framecount)
    @frame = frame
    @framecount = framecount
    
  end

  def validate

    # disallow rolls > 10    

    @frame[0] = 10 if (@frame[0] > 10) 
    @frame[1] = 10 if (@frame[1] > 10)
    if (@framecount == 10)
      @frame[2] = 10 if (@frame[2] > 10)
    end

    # if first roll is a strike, discount 2nd roll, unless it's the 10th @frame
    if (@framecount < 10)
      @frame[1] = 0 if (@frame[0] == 10)
    end
    
    @frame
  end
  
  
end