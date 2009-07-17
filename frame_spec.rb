require "rubygems"
require "spec"

require "frame"

describe Frame do

  describe "validate" do

    it "checks for illegal frames and corrects" do
      f = Frame.new([16,0], 5)
      f.validate
      f.rolls.should == [10,0]
    end
    
    it "gets correct results from a legal frame" do
      f = Frame.new([6,3], 5)
      f.validate
      f.rolls.should == [6,3]
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


