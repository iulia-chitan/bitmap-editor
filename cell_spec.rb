require 'rspec'
require_relative 'cell'

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



end