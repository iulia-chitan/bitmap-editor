require_relative 'image'

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

  def get_neighbors image
    coord = image.get_cell_coordinates(self)
    v_neighbors = [image.get_cell(coord[0], coord[1]-1), image.get_cell(coord[0], coord[1]+1)]
    h_neighbors = [image.get_cell(coord[0]-1, coord[1]), image.get_cell(coord[0]+1, coord[1])]
    neighbors = (v_neighbors + h_neighbors).compact
  end


  def get_region_cells image, color, visited = [], in_region = []
    all_cells = image.all_cells
    visited << self
    visited.uniq!

    in_region << self if self.value == color
    in_region.uniq!
    nb = get_neighbors(image) - visited
    nb.each do |cell|
      if visited.include?(all_cells)
        break
      else
        cell.get_region_cells image, color, visited, in_region
      end

    end

    return in_region

  end
end