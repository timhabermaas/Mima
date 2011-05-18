require './lib/tokenizer'
require './lib/mima'
require './init.rb'

tokenizer = Tokenizer.new(File.open("test.mima"))
mima = Mima.new(tokenizer)
mima.run

p "Akku: #{mima.akku}"