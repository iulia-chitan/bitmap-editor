require 'rspec'
require_relative 'image'

describe Image do

  [[], [1], [1,2,3], nil].each do |k|
    it 'should raise error if number of param is not correct' do
      expect{ Image.new(*k)}.to raise_error(ArgumentError)
    end
  end


end