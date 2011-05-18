class Cell
  attr_writer :value

  def initialize(value = nil)
    @value = value || 0
  end

  def value(vm)
    @value
  end
end