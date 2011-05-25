require './lib/crazy_number'

describe CrazyNumber do

  it "should overflow" do
    CrazyNumber.new(16, 4).to_i.should == 0
  end

  it "should handle negative numbers properly" do
    CrazyNumber.new(-1, 4).to_i.should == 0xF
    CrazyNumber.new(-2, 4).to_i.should == 0xE
  end

  it "should add two crazy numbers properly" do
    (CrazyNumber.new(10, 4) + CrazyNumber.new(10, 4)).to_i.should == 4
  end

  it "should handle addition with Fixnums" do
    (CrazyNumber.new(10, 4) + 10).to_i.should == 4
  end

  it "should handle addition with negative Fixnums" do
    (CrazyNumber.new(10, 4) + -1).to_i.should == 9
  end

  it "should handle subtraction with Fixnums" do
    (CrazyNumber.new(10, 4) - 11).to_i.should == 15
  end

  it "should allow addition being commutative" do
    (2 + CrazyNumber.new(15, 4)).to_i.should == 1
  end
end