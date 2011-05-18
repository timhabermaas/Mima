class Command
  attr_reader :opcode

  def initialize(opcode, block)
    @opcode = opcode
    @block = block
  end

  def execute(machine, argument)
    @block.call(machine, argument) unless @block.nil?
  end
end