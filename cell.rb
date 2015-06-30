class Cell

  attr_accessor :value
  def initialize(value = "")
    raise 'Please insert correct value for this cell' if value.is_a?(Integer)
    @value = value
  end

end