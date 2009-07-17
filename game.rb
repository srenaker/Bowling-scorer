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

      if (has_spare)
        score += (f.total + f.rolls[0])
        has_spare = false

      elsif (has_strike) 
        score += (f.total * 2)
 
        if f.strike?
          has_2_strikes = true
          has_strike = false
        else
          has_strike = false 
        end

      elsif (has_2_strikes)
        score += f.score_with_two_strikes
        
        if f.strike?
          has_2_strikes = true
        else
          has_strike = false 
          has_2_strikes = false 
        end
    
      else  
        score += f.total
      end

      if (f.strike? && has_2_strikes == false)
        has_strike = true

      elsif f.spare?
        has_spare = true
      end

      index += 1

    end
    score
  end

end
