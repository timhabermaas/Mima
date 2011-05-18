class Cell
  attr_accessor :value

  def initialize(value = nil)
    @value = value || 0
  end
end