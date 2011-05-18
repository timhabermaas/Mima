require 'command'
require 'instruction'

class Mima
  @@commands = {}

  attr_reader :memory, :akku

  def self.add_command(c, opcode, &block)
    @@commands[c] = Command.new(opcode, block)
  end

  def self.init(&block)
    yield self
  end

  def initialize(tokenizer)
    @memory = Hash.new do |hash, key|
      hash[key] = Instruction.new(:dummy_command, 0)
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
          if @@commands[t[0].to_sym]
            Instruction.new t[0], replace_constant(t[1])
          else
            @labels[t[0].to_sym] = pointer
            Instruction.new t[1]
          end
        else
          Instruction.new t[0]
        end
      pointer += 1
    end
  end

  def run
    @program_counter = @labels[:start]

    while not @stopped
      cmd = @memory[@program_counter]
      if @@commands[cmd.command].nil?
        raise "Unknown command '#{cmd.command}'"
      else
        @@commands[cmd.command].execute self, cmd.resolved_argument(self)
      end
      if @program_counter_was_just_set
        @program_counter_was_just_set = false
      else
        @program_counter += 1
      end
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

  def akku_is_negative?
    @akku & 0x800000 != 0
  end

  def akku=(a)
    @akku = a & 0xFFFFFF
  end

  def program_counter=(c)
    @program_counter = c
    @program_counter_was_just_set = true
  end

private
  def replace_constant(argument)
    @constants[argument] || argument
  end
end