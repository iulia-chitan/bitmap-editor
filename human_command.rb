require_relative 'image'

class HumanCommand

  #validate string argument
  def self.check_cmd_str str
    param_no = str.split(' ').size
    raise 'Please insert correct command string' unless [1,3,4,5].include?(param_no)
    regex = get_string_regex(param_no)
    raise 'Please insert correct command string' if str.match(regex).nil?
    return true
  end

  # check if string argument matches all command forms
  def self.get_string_regex n
    regex = case n
      when 1 then /(^C|S|X$){1}/
      when 3 then /(^I(\s\d){2}$){1}/
      when 4 then /(^L|F){1}(\s\d){2}\s([A-Z]$){1}/
      when 5 then /(^V|H){1}(\s\d){3}([A-Z]$){1}/
    end
    return regex
  end

  # should return method name from first letter input
  def self.map_command_to_image_method str
    result = case str
                  when 'S' then "show"
                  when 'C' then "clear_image"
                  when 'X' then "terminate_session"
                  when 'I' then "new"
                  when 'L' then "color_pixel"
                  when 'V' then "draw_vertical"
                  when 'H' then "draw_horizontal"
                  when 'F' then "fill_in"
             end
    return result
  end

  #should return method name and params
  def self.human_command str
    params_arr = str.split(' ')
    meth = map_command_to_image_method(params_arr.first)
    meth_params = params_arr - [params_arr[0]]
    if meth_params.size >= 3
      color = meth_params.last
      integer_params = (meth_params - [color]).map(&:to_i)
      params = [integer_params] + [color]
    else
      params = meth_params.map(&:to_i)
    end
    return [meth, params.flatten]
  end

end