require "frame"

class Game
  
  def score(state)

    framecount = 1
    score = 0
    has_spare = false
    has_strike = false
    has_2_strikes = false

    state.each do |frame|
      
      frame = Frame.new(frame, framecount).validate_frame

      frame_total = frame.inject(0) { |x,n| x+n }

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
  
  
end

