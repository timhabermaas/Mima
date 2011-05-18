require 'mima'

Mima.init do |m|
  m.add_command(:ds,  0)

  m.add_command(:ldc, 0) do |vm, argument|
    vm.akku = argument
  end

  m.add_command(:ldv, 1) do |vm, argument|
    vm.akku = vm.memory[argument].value(vm)
  end

  m.add_command(:stv, 2) do |vm, argument|
    vm.memory[argument].value = vm.akku
  end

  m.add_command(:add, 3) do |vm, argument|
    vm.akku = vm.akku + vm.memory[argument].value(vm)
  end

  m.add_command(:and, 4) do |vm, argument|
    vm.akku = vm.akku & vm.memory[argument].value(vm) # TODO shorcut for accessing memory
  end

  m.add_command(:and, 5) do |vm, argument|
    vm.akku = vm.akku | vm.memory[argument].value(vm)
  end

  m.add_command(:xor, 6) do |vm, argument|
    vm.akku = vm.akku ^ vm.memory[argument].value(vm)
  end

  m.add_command(:eql, 7) do |vm, argument|
    if vm.akku == argument # vm.memory[argument].value(vm) ?
      vm.akku = -1
    else
      vm.akku = 0
    end
  end

  m.add_command(:jmp, 8) do |vm, argument|
    vm.program_counter = argument
  end

  m.add_command(:jmn, 9) do |vm, argument|
    vm.program_counter = argument if vm.akku_is_negative?
  end

  m.add_command(:ldiv, 10) do |vm, argument|
    vm.akku = vm.memory[vm.memory[argument].value(vm)].value(vm)
  end

  m.add_command(:stiv, 11) do |vm, argument|
    vm.memory[vm.memory[argument].value(vm)].value = vm.akku
  end

  m.add_command(:jms, 12) do |vm, argument|
  end

  m.add_command(:jind, 13) do |vm, argument|
  end

  m.add_command(:halt, 240) do |vm, argument|
    vm.stop!
  end

  m.add_command(:not, 241) do |vm, argument|
    vm.akku = ~vm.akku
  end

  m.add_command(:rar, 242) do |vm, argument|
    vm.akku = (vm.akku >> count) | (vm.akku << (24 - count))
  end
end