require 'rspec'
require_relative 'image'

describe Image do

  [[], [1], [1,2,3], nil].each do |k|
    it 'should raise error if number of param is not correct' do
      expect{ Image.new(*k)}.to raise_error(ArgumentError)
    end
  end

  [[1, 'a'], ['a', 'b'], ['a', 2]].each do |k|
    it 'should raise error if param string is not correct' do
      expect{ Image.new(*k)}.to raise_error(RuntimeError, 'Please insert correct type of arguments')
    end
  end


  [[1,2], [2,2], [3,2]].each do |k|
    it 'should initialize a new image matrix' do
      grid = Image.new(*k).matrix
      expect(grid.flatten.map(&:value).uniq).to eq(['O'])
      expect(grid.size).to eq(k[0])
      expect(grid.map{|e| e.size}.uniq).to eq([k[1]])
    end

  end

  before(:each) do
    @image =  Image.new(5,5)
  end


  [[1,1], [2,4], [5,3]].each do |k|
    it 'should get the right coordinates' do
       cell = @image.get_cell(k.first, k.last)
       expect(@image.get_cell_coordinates(cell)).to eq(k)
    end
  end



  it 'should return correct cells on vertical' do
    coord = [2, 3, 4]
    cells = [@image.get_cell(2,4), @image.get_cell(3,4)]
    expect(@image.get_v_cells(*coord)).to eq(cells)
  end

  it 'should return correct cells on horizontal' do
    coord =  [2, 3, 4]
    cells = [@image.get_cell(2,3), @image.get_cell(2,4)]
    expect(@image.get_h_cells(*coord)).to eq(cells)
  end






end