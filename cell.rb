class Cell

  attr_accessor :value

  def initialize(value = "O")
    raise 'Please insert correct value for this cell' unless ('A'..'Z').include?(value)
    @value = value
  end


  def color(val)
    raise 'Please provide a valid cell color' unless ('A'..'Z').include?(val)
    self.value = val
  end

end