class Game
  
  def current_score(state)

    framecount = 1
    score = 0
    has_spare = false
    has_strike = false
    has_2_strikes = false
    

    state.each do |frame|
      
      frame = validate_frame(frame, framecount)

      if (framecount < 10)
        frame_total = frame[0] + frame[1]
      else
        frame_total = frame[0] + frame[1] + frame[2]
      end

      if (has_spare)        
        score += (frame_total + frame[0])
        has_spare = false
      elsif (has_strike)
 
        score += (frame_total * 2)
 
        if (frame[0] == 10)
          has_2_strikes = true
          has_strike = false
        else
          has_strike = false 
        end

      elsif (has_2_strikes)
        if (framecount < 10)
          score += ((frame[0] * 3) + (frame[1] * 2))  
        else
          score += ((frame[0] * 3) + (frame[1] * 2) + frame[2])  
        end 
        
        if (frame[0] == 10)
          has_2_strikes = true
        else
          has_strike = false 
          has_2_strikes = false 
        end
    
      else  
        score += frame_total
      end

      if (frame[0] == 10 && has_2_strikes == false)
        has_strike = true

      elsif (frame_total == 10 && frame[0] != 10)
        has_spare = true
      end

      framecount += 1

    end
    score
  end
  
  def validate_frame(frame, framecount)

    # disallow rolls > 10    

    frame[0] = 10 if (frame[0] > 10) 
    frame[1] = 10 if (frame[1] > 10)
    if (framecount == 10)
      frame[2] = 10 if (frame[2] > 10)
    end

    # if first roll is a strike, discount 2nd roll, unless it's the 10th frame
    if (framecount < 10)
      frame[1] = 0 if (frame[0] == 10)
    end
    
    frame
  end
  
end

