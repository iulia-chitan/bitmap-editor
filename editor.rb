require_relative 'image'
require_relative 'human_command'
class Editor
  attr_reader :image

  def initialize(image = Image.new(2,2))
    @image = image
  end

  def request_cmd
    puts = "Enter your command: "
  end

  def get_command(cmd = gets.chomp)
    HumanCommand.check_cmd_str cmd
    meth, params = HumanCommand.human_command(cmd)
    if meth.eql?('terminate_session')
      puts 'Bye Bye'
      return
    else
      request_cmd
      exec_command(meth, params)
      get_command
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