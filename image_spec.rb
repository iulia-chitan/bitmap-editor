require 'rspec'
require_relative 'image'

RSpec::Matchers.define :match_stdout do |check|

  @capture = nil

  match do |block|

    begin
      stdout_saved = $stdout
      $stdout      = StringIO.new
      block.call
    ensure
      @capture     = $stdout
      $stdout      = stdout_saved
    end

    @capture.string.match check
  end


  def supports_block_expectations?
    true
  end
end




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



  it 'should display the image matrix' do
    image = Image.new(2,2)
    expect { image.show }.to match_stdout("O\tO\nO\tO")
  end

  it 'should clear the image matrix' do
    image = Image.new(2,2)
    image.all_cells.each{|c| c.color 'M'}
    image.clear_image
    expect( image.all_cells.map(&:value).uniq ).to eq(['O'])
  end

  it 'should color the pixel' do
    image = Image.new(2,2)
    image.color_pixel(2,2,'M')
    expect( image.get_cell(2,2).value ).to eq('M')
  end

  it 'should fill in region' do
    image = Image.new(2,2)
    image.fill_in(2,1,'M')
    expect( image.all_cells.map(&:value).uniq ).to eq(['M'])
  end

  it 'should draw a vertical line with color' do
    image = Image.new(2,2)
    image.draw_vertical 1,2,1,'M'
    expect( image.get_cell(1,1).value ).to eq('M')
    expect( image.get_cell(2,1).value ).to eq('M')
  end

  it 'should draw an horizontal line with color' do
    image = Image.new(2,2)
    image.draw_horizontal 1,1,2,'M'
    expect( image.get_cell(1,1).value ).to eq('M')
    expect( image.get_cell(1,2).value ).to eq('M')
  end

end