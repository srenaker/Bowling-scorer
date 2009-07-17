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
      f = Frame.new([10,3,5], 10)
      f.validate
      f.rolls.should == [10,3,5]
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

end


