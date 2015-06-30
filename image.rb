class Image

  attr_reader :matrix

  def initialize(cols, rows)
    raise 'Please insert correct type of arguments' unless cols.is_a?(Integer) && rows.is_a?(Integer)
    @matrix = default_matrix(cols, rows)
  end


  def default_matrix(x,y)
    Array.new(y) { Array.new(x) { '0' } }
  end

end