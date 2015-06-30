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
      expect(Image.new(*k).matrix).to eq(Array.new(k[1]){Array.new(k[0]) { '0' }})
    end

  end



end