require "frame"

class Game
  
  def score(state)

    index = 1
    score = 0
    has_spare = false
    has_strike = false
    has_2_strikes = false

    state.each do |rolls|
      
      f = Frame.new(rolls, index)
      f.validate

      frame_total = f.rolls.inject(0) { |x,n| x+n }

      if (has_spare)        
        score += (frame_total + f.rolls[0])
        has_spare = false
      elsif (has_strike)
 
        score += (frame_total * 2)
 
        if (f.rolls[0] == 10)
          has_2_strikes = true
          has_strike = false
        else
          has_strike = false 
        end

      elsif (has_2_strikes)
        if (index < 10)
          score += ((f.rolls[0] * 3) + (f.rolls[1] * 2))  
        else
          score += ((f.rolls[0] * 3) + (f.rolls[1] * 2) + f.rolls[2])  
        end 
        
        if (f.rolls[0] == 10)
          has_2_strikes = true
        else
          has_strike = false 
          has_2_strikes = false 
        end
    
      else  
        score += frame_total
      end

      if (f.rolls[0] == 10 && has_2_strikes == false)
        has_strike = true

      elsif (frame_total == 10 && f.rolls[0] != 10)
        has_spare = true
      end

      index += 1

    end
    score
  end
  
  
end

