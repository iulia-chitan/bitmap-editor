require_relative 'image'
require_relative 'human_command'
class Editor
  attr_reader :image

  def initialize(image = Image.new(2,2))
    @image = image
  end

  def request_cmd
    puts "Enter your command: "
  end

  def get_command(cmd = gets.chomp)
    cmd_cond = HumanCommand.check_cmd_str cmd
    unless cmd_cond
      request_cmd
      get_command
    else
      meth, params = HumanCommand.human_command(cmd)
      if meth.eql?('terminate_session')
        puts 'Bye Bye'
        return
      else
        exec_command(meth, params)
        request_cmd
        get_command
      end
    end
  end

  def exec_command(cmd, params)
    if params.empty?
      image.send(cmd.to_sym)
    else
      image.send(cmd.to_sym, *params)
    end
  end




end