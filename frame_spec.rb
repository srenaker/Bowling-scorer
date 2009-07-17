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

end


