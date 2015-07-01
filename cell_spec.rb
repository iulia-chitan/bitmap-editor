require 'rspec'
require_relative 'cell'
require_relative 'image'

describe Cell do

  (1..5).each do |k|
    it 'should raise error if param string is not correct' do
      expect{ Cell.new(k)}.to raise_error(RuntimeError, 'Please insert correct value for this cell')
    end
  end


  ('A'..'Z').each do |k|
    it 'should initialize a new cell in the matrix' do
      expect(Cell.new(k).value).to eq(k)
    end

  end

  it 'should initialize a new cell in the matrix' do
    expect(Cell.new().value).to eq('O')
  end

  [1, 5, 0, 45, 37, '/'].each do |k|
    it 'should raise error if color char is not correct' do
      cell = Cell.new
      expect{ cell.color(k)}.to raise_error(RuntimeError, 'Please provide a valid cell color')
    end
  end


  ['A','D','W','Z','M'].each do |k|
    it 'should color the cell' do
      cell = Cell.new
      cell.color(k)
      expect(cell.value).to eq(k)
    end
  end


  it 'should return correct neighbors' do
    @image =  Image.new(3,3)
    @cell = @image.get_cell(1,2)
    @cell.color('Z')

    @neighbors = @cell.get_neighbors(@image)
    expect(@neighbors.map{|c| @image.get_cell_coordinates(c)}).to eq([[1,1], [1,3], [2,2]])
  end


  it 'should return correct region cells' do
    @image =  Image.new(2,2)
    @cell = @image.get_cell(2,2)
    @cell2 = @image.get_cell(1,2)
    @cell.color('Z')
    @cell2.color 'Z'
    @reg = @cell.get_region_cells(@image, @cell.value, [], [])
    expect(@reg).to eq([@cell, @cell2])
  end


end