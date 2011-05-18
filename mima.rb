require './lib/tokenizer'
require './lib/mima'
require './init.rb'

tokenizer = Tokenizer.new(File.open("test.mima"))
#parser = Parser.new(lexer, nil)
#parser.parse
mima = Mima.new(tokenizer)
mima.run

p mima.akku