require "rubygems"
require "spec"

require "game"

describe Game do
  
  describe "score" do
    
    it "calculates current score after one frame" do
      state = [[2,5]]
      Game.new.current_score(state).should == 7
    end
    
    it "calculates current score after one frame, with spare" do
      state = [[5,5]]
      Game.new.current_score(state).should == 10
    end
    
    it "calculates current score after one frame, with strike" do
      state = [[10,0]]
      Game.new.current_score(state).should == 10
    end    
    
    it "calculates current score after several frames" do
      state = [[2,5], [5,3], [4,4], [2,1]]      
      Game.new.current_score(state).should == 26
    end

    it "calculates current score after several frames, spare included" do
      state = [[2,5], [5,5], [4,4], [2,1]]      
      Game.new.current_score(state).should == 32
    end
    
    it "calculates current score after several frames, strike included" do
      state = [[2,5], [10,0], [4,4], [2,1]]      
      Game.new.current_score(state).should == 36
    end    
    
    it "calculates current score after several frames, spare and strike included" do
      state = [[2,5], [10,0], [4,4], [2,8], [3,5]]      
      Game.new.current_score(state).should == 54
    end        
    
    it "calculates current score after several frames, with consecutive spare and strike" do
      state = [[2,5], [9,1], [10,0], [4,4], [2,1]]      
      Game.new.current_score(state).should == 56
    end        
    
    it "calculates current score after several frames, with 2 consecutive strikes" do
      state = [[10,0], [10,0], [2,1]]      
      Game.new.current_score(state).should == 38
    end            

    it "calculates current score after several frames, with 3 consecutive strikes (TURKEY!)" do
      state = [[10,0], [10,0], [10,0], [0,9]]      
      Game.new.current_score(state).should == 78
    end            
    
    it "calculates current score after several frames, with 4 consecutive strikes" do
      state = [[10,0], [10,0], [10,0], [10,0], [4,3]]      
      Game.new.current_score(state).should == 108
    end            
    
    it "calculates current score for a full game, with confusingly mixed strikes and spares" do
      state = [[10,0], [3,4], [10,0], [1,9], [10,0], [10,0], [5,5], [4,4], [8,2], [10,4,6]]      
      Game.new.current_score(state).should == 171
    end                
    
    it "calculates current score for a full game, with mixed strikes and spares" do
      state = [[10,0], [3,4], [10,0], [1,9], [10,0], [10,0], [5,5], [4,4], [8,2], [10,10,10] ]     
      Game.new.current_score(state).should == 181
    end

    it "calculates current score for a full game, with mixed strikes and spares" do
      state = [[10,0], [3,4], [10,0], [1,9], [10,0], [10,0], [5,5], [4,4], [8,2], [3,7,8] ]     
      Game.new.current_score(state).should == 162
    end

    it "calculates current score for a perfect game" do
      state = [[10,0], [10,0], [10,0], [10,0], [10,0], [10,0], [10,0], [10,0], [10,0], [10,10,10] ]     
      Game.new.current_score(state).should == 300
    end
    
    it "checks for illegal frames and corrects" do
      state = [[10, 4], [35, 0], [14,15]]
      Game.new.current_score(state).should == 60
    end
    
   it "checks for an illegal 10th frame and corrects" do
      state = [[10,0], [10,0], [10,0], [10,0], [10,0], [10,0], [10,0], [10,0], [10,0], [10,66,8997] ]     
      Game.new.current_score(state).should == 300
    end
    
  end
end	
	
