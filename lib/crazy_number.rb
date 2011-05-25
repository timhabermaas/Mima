class CrazyNumber
  def initialize(number, bits = 32)
    @number = number & (2**bits - 1)
    @bits = bits
  end

  def to_i
    @number
  end

  def +(other)
    CrazyNumber.new(@number + other.to_i, @bits)
  end

  def -(other)
    CrazyNumber.new(@number - other.to_i, @bits)
  end

  def coerce(other)
    [self, other]
  end
end