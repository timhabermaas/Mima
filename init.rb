Mima.init do |m|
  m.add_command(:ds,  0)
  m.add_command(:ldc, 0) do |vm, argument|
    vm.akku = argument
  end
  m.add_command(:ldv, 1) do |vm, argument|
    vm.akku = vm.memory[argument].value(vm)
  end
  m.add_command(:stv, 2)
  m.add_command(:add, 3)
  m.add_command(:and, 4)
  m.add_command(:or,  5)
  m.add_command(:xor, 6)
  m.add_command(:eql, 7)
  m.add_command(:jmp, 8)
  m.add_command(:jmn, 9)
  m.add_command(:ldiv, 10)
  m.add_command(:stiv, 11)
  m.add_command(:jms, 12)
  m.add_command(:jind, 13)

  m.add_command(:halt, 240)
  m.add_command(:not, 241)
  m.add_command(:rar, 242)
end