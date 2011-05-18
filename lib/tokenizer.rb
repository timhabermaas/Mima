class Tokenizer
  def initialize(input)
    @input = input
  end

  def next
    line = @input.readline.chomp.strip
    remove_comment line
    line = line.split(/[ :]+/).collect { |s| s.downcase }
  end

  def eof?
    @input.eof?
  end

private
  def remove_comment(line)
    line.gsub!(/;.*/, "")
  end
end