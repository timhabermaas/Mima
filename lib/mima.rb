require './lib/command'
require './lib/instruction'
require './lib/cell'

class Mima
  @@commands = {}

  attr_accessor :akku
  attr_reader :memory

  def self.add_command(c, opcode, &block)
    @@commands[c] = Command.new(opcode, block)
  end

  def self.init(&block)
    yield self
  end

  def initialize(tokenizer)
    @memory = Hash.new do |hash, key|
      hash[key] = Cell.new(0)
    end
    @labels = Hash.new do |hash, key|
      raise "Unknown label '#{key}'"
    end
    @akku = 0
    @constants = {}
    pointer = 0

    while not tokenizer.eof?
      t = tokenizer.next
      next if t.empty?

      if t[0] == "*" and t[1] == "="
        pointer = t[2].to_i
        next
      end
      if t[1] == "="
        @constants[t[0]] = t[2]
        next
      end

      @memory[pointer] =
        if t.size == 3
          @labels[t[0].to_sym] = pointer
          Instruction.new t[1], replace_constant(t[2]), t[0]
        elsif t.size == 2
          Instruction.new t[0], replace_constant(t[1])  # TODO reihenfolge (ADD HALT) check for first being a command
          # @labels[t[0].to_sym] = pointer
        else
          Instruction.new t[0]
        end
      pointer += 1
    end
  end

  def run
    pointer = @labels[:start]

    while not @stopped
      cmd = @memory[pointer]
      if @@commands[cmd.command].nil?
        raise "Unknown command '#{cmd.command}'"
      else
        @@commands[cmd.command].execute self, cmd.resolved_argument(self)
      end
      pointer += 1
    end
  end

  def opcode_for(command)
    @@commands[command].opcode
  end

  def resolve_label(label)
    @labels[label.to_sym]
  end

  def stop!
    @stopped = true
  end

private
  def replace_constant(argument)
    @constants[argument] || argument
  end
end