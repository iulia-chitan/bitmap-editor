require_relative 'cell'

class Image

  attr_reader :matrix, :rows, :cols


  def initialize(rows, cols)
    raise 'Please insert correct type of arguments' unless cols.is_a?(Integer) && rows.is_a?(Integer)
    @matrix = default_matrix(rows, cols)
    @rows = rows
    @cols = cols
  end

  #initialize matrix with new cells of default value - 'O'
  def default_matrix(x,y)
    Array.new(x) { Array.new(y) { Cell.new } }
  end

  # returns all matrix cells
  def all_cells
    matrix.flatten
  end

  #gets a cells coordinates
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

  #return cell from coordinates
  def get_cell x, y
    return nil if x-1 < 0 || y-1 < 0 || x-1 >= rows || y-1 >= cols
    matrix[x-1][y-1] rescue nil
  end

  # gets cells array for draw_vertical method
  def get_v_cells x1, x2, y
    cells = []
    x_range = x1 > x2 ? x1.downto(x2).collect { |i| i} : x1.upto(x2).collect { |i| i}
    x_range.each do |x|
      cells << get_cell(x, y)
    end
    return cells
  end

  # gets cells array for draw_horizontal method
  def get_h_cells x, y1, y2
    cells = []
    y_range = y1 > y2 ? y1.downto(y2).collect { |i| i} : y1.upto(y2).collect { |i| i}
    y_range.each do |y|
      cells << get_cell(x, y)
    end
    return cells
  end

  #displays image matrix
  def show
    img = matrix.collect { |line| line.map(&:value).join("\t") }.join("\n")
    puts img
  end

  #sets all cells from matrix to default value
  def clear_image
    all_cells.each { |cell| cell.value = 'O' }
  end

  #destroys current image and session
  def terminate_session

  end

  #sets cell value from coordinates to color
  def color_pixel x, y, color
   cell = get_cell(x,y)
   cell.value = color
  end

  #sets all cells value from region to color
  def fill_in x, y, color
    cell = get_cell(x,y)
    cells = cell.get_region_cells self, cell.value
    cells.each{|c| c.color(color)}
  end

  #colors vertical line to color
  def draw_vertical x1,x2,y,color
    cells = get_v_cells(x1,x2,y)
    cells.each{|c| c.color(color)}
  end

  #colors horizontal line to color
  def draw_horizontal x,y1,y2,color
    cells = get_h_cells(x,y1,y2)
    cells.each{|c| c.color(color)}
  end

  #executes method in the context of current object
  def exec_human_command meth, meth_params = []
     self.send(meth, *meth_params)
  end

end