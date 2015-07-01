require_relative 'image'
require_relative 'cell'
require_relative 'human_command'
require_relative 'editor'

class BitmatEditor

  def self.init_session(cmd = gets.chomp)
    cmd_cond = HumanCommand.check_cmd_str cmd
    meth, params = HumanCommand.human_command(cmd)
    return nil unless (meth.eql?('new') && cmd_cond)
    @image = Image.send(meth.to_sym, *params)
    return @image
  end


  puts "Welcome to your interactive bitmap editor"

  while @image.nil?
    puts "Please initialize your image:"
    @image = init_session
  end

  @editor = Editor.new(@image)
  @editor.request_cmd
  @editor.get_command


end