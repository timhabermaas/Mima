require './lib/tokenizer'
require './lib/mima'
require './init.rb'

tokenizer = Tokenizer.new(File.open("test.mima"))
mima = Mima.new(tokenizer)
mima.run

puts "Akku: 0x#{mima.akku.to_s(16)}"