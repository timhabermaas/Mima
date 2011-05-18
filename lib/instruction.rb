require './lib/core_ext'

class Instruction

  attr_reader :command

  def initialize(command, argument = nil, label = nil)
    @command = command.to_sym
    @argument = argument
    @label = label
  end

  def value(machine)
    shift = machine.opcode_for(@command) > 15 ? 16 : 20
    (machine.opcode_for(@command) << shift) +
      resolved_argument(machine)
  end

  def resolved_argument(machine)
    if @argument.nil?
      0
    elsif @argument.numeric?
      Integer(@argument) # it can even handle hex :)
    else
      machine.resolve_label(@argument)
    end
  end
end