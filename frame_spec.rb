require "rubygems"
require "spec"

require "frame"

describe Frame do

  describe "validate" do

    it "checks for illegal frames and corrects" do
      f = Frame.new([16,0], 5)
      f.validate
      f.rolls.should == [10]
    end
    
    it "gets correct results from a legal frame" do
      f = Frame.new([6,3], 5)
      f.validate
      f.rolls.should == [6,3]
    end    

    it "if first roll is a strike, discount 2nd roll" do
      f = Frame.new([10,3], 5)
      f.validate
      f.rolls.should == [10]
    end

    it "if first roll is a strike, but it's the 10th frame, don't discount 2nd roll" do
      f = Frame.new([10,3,5], 10)
      f.validate
      f.rolls.should == [10,3,5]
    end

    it "only allows two rolls per frame if it's not the 10th frame" do
      f = Frame.new([4,3,5], 5)
      f.validate
      f.rolls.should == [4,3]
    end

    it "only allows one roll per frame if it's a strike and not the 10th frame" do
      f = Frame.new([10,3,5], 5)
      f.validate
      f.rolls.should == [10]
    end

    it "allows three rolls in the 10th frame if the first roll is a 10" do
      f = Frame.new([10,3,5], 10)
      f.validate
      f.rolls.should == [10,3,5]
    end
        
    it "allows three rolls in the 10th frame if the first two rolls add up to 10" do
      f = Frame.new([7,3,5], 10)
      f.validate
      f.rolls.should == [7,3,5]
    end

  end

  describe "total" do
    
    it "adds up a frame with one roll" do
      Frame.new([1], 1).total.should == 1
    end

    it "adds up a frame with two rolls" do
      Frame.new([1,2], 1).total.should == 3
    end
    
    it "adds up a frame with three rolls" do
      Frame.new([1,2,3], 1).total.should == 6
    end
    
  end

  describe "strike" do
    it "is a strike if the first roll is 10" do
      Frame.new([10], 8).should be_strike
    end

    it "isn't a strike if the first roll isn't 10" do
      Frame.new([4,5], 8).should_not be_strike
    end
    
    it "is a strike in the final frame if the first two rolls are both 10" do
      Frame.new([10, 10, 0], 10).should be_strike
    end
    
    it "is a strike in the final frame if the first three rolls are 10" do
      Frame.new([10, 10, 10], 10).should be_strike
    end
    
  end

  describe "spare" do
    it "isn't a spare if it's a strike" do
      Frame.new([10], 8).should_not be_spare
    end

    it "is a spare if the total is 10" do
      Frame.new([6,4], 8).should be_spare
    end

    it "isn't a spare if the total isn't 10" do
      Frame.new([4,5], 8).should_not be_spare
    end
  end

  describe "score_with_two_strikes" do
    # if (index < 10)
    #   ((rolls[0] * 3) + (rolls[1] ? rolls[1] * 2 : 0))
    # else
    #   ((rolls[0] * 3) + (rolls[1] * 2) + rolls[2])  
    # end

    it "counts the first roll 3 times when that roll is a strike" do
      Frame.new([10], 8).score_with_two_strikes.should == 30
    end

    it "counts the first roll 3 times when that roll is not a strike" do
      Frame.new([7], 8).score_with_two_strikes.should == 21
    end

    it "counts the first roll 3 times and the second roll twice" do
      Frame.new([1,2], 8).score_with_two_strikes.should == 7
      Frame.new([3,4], 8).score_with_two_strikes.should == 17
    end
      
    it "counts the first roll 3 times and the second roll twice and the third roll once" do
      Frame.new([10,2,3], 10).score_with_two_strikes.should == 37
    end

    it "counts the first roll 3 times and the second roll twice and the third roll once even if he second roll is a 10" do
      Frame.new([10,10,3], 10).score_with_two_strikes.should == 53
    end

  end
end
