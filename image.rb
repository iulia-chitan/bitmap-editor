class Image

  attr_reader :matrix, :rows, :cols

  def initialize(rows, cols)
    raise 'Please insert correct type of arguments' unless cols.is_a?(Integer) && rows.is_a?(Integer)
    @matrix = default_matrix(rows, cols)
    @rows = rows
    @cols = cols
  end


  def default_matrix(x,y)
    Array.new(x) { Array.new(y) { Cell.new } }
  end

  def all_cells
    matrix.flatten
  end


  def get_cell_coordinates cell
    coord = []
    for i in 0..rows-1
      for j in 0..cols-1
        if matrix[i][j] == cell
          coord = [i+1, j+1]
        end
      end
    end
    return coord
  end

  def get_cell x, y
    return nil if x-1 < 0 || y-1 < 0 || x-1 >= rows || y-1 >= cols
    matrix[x-1][y-1] rescue nil
  end



end