require 'rspec'
require_relative 'human_command'
require_relative 'output_helper'

describe HumanCommand do

  ['I 5', 'S 3', 'H 2 3 M' , 'F 4 C', 'I65'].each do |cmd_str|
    it 'should raise error if number of param is not correct' do
      expect{ HumanCommand.check_cmd_str(cmd_str)}.to match_stdout("Please insert valid command string")
    end
  end

  ['I 5 3', 'S', 'H 2 3 4 M' , 'F 4 3 C'].each do |cmd_str|
    it 'should pass command check if string is correct' do
      expect{ HumanCommand.check_cmd_str(cmd_str)}.to be_true
    end
  end

  {'I 5 3' => 'new', 'S' => 'show', 'H 2 3 4 M' => 'draw_horizontal', 'F 4 3 C' => 'fill_in'}.each_pair do |k, v|
    it "should return #{v} as method name if string argument is #{k}" do
      expect(HumanCommand.map_command_to_image_method(k.split(' ').first)).to eq(v)
    end
  end

  {'I 5 3' => ['new', [5, 3]], 'S' => ['show', []], 'H 2 3 4 M' => ['draw_horizontal', [2, 3, 4,'M']], 'F 4 3 C' => ['fill_in', [4, 3,'C']]}.each_pair do |k, v|
    it "should return return #{v} as method name and params array if string argument is #{k}" do
      expect(HumanCommand.human_command(k)).to eq(v)
    end
  end

end