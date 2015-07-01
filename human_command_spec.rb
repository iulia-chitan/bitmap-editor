require 'rspec'
require_relative 'human_command'

describe HumanCommand do

  ['I 5', 'S 3', 'H 2 3 M' , 'F 4 C'].each do |cmd_str|
    it 'should raise error if number of param is not correct' do
      expect{ HumanCommand.check_cmd_str(cmd_str)}.to raise_error(RuntimeError, 'Please insert correct command string')
    end
  end

  ['I 5 3', 'S', 'H 2 3 4 M' , 'F 4 3 C'].each do |cmd_str|
    it 'should pass command check if string is correct' do
      expect{ HumanCommand.check_cmd_str(cmd_str)}.to be_true
    end
  end
end