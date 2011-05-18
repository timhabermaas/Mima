require './lib/instruction'

class Dummy
end

describe Instruction do
  it "should return the actual value for DS" do
    vm = mock(Dummy)
    vm.should_receive(:opcode_for).at_least(:once).with(:ds).and_return(0)
    Instruction.new(:ds, "113").value(vm).should == 113
  end

  it "should return the actual value for DS and given hex" do
    d = mock(Dummy)
    d.should_receive(:opcode_for).at_least(:once).with(:ds).and_return(0)
    Instruction.new(:ds, "0xFFFFFF").value(d).should == 16777215
  end

  it "should shift opcode properly" do
    d = mock(Dummy)
    d.should_receive(:opcode_for).at_least(:once).with(:or).and_return(5)
    Instruction.new(:or, "3").value(d).should == "500003".to_i(16)
  end

  it "should shift opcode properly for opcodes > 15" do
    d = mock(Dummy)
    d.should_receive(:opcode_for).at_least(:once).with(:or).and_return(255)
    Instruction.new(:or).value(d).should == "FF0000".to_i(16)
  end

  it "should lookup label's memory cell" do
    d = mock(Dummy)
    d.should_receive(:resolve_label).at_least(:once).with("muh").and_return(16)
    d.should_receive(:opcode_for).at_least(:once).with(:or).and_return(0)
    Instruction.new(:or, "muh").value(d).should == 16
  end

  it "should return the value once it was set" do
    i = Instruction.new(:or)
    i.value = 20
    i.value(Dummy.new).should == 20
  end
end