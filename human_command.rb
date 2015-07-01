class HumanCommand

  def self.check_cmd_str str
    param_no = str.split(' ').size
    raise 'Please insert correct command string' unless [1,3,4,5].include?(param_no)
    regex = get_string_regex(param_no)
    raise 'Please insert correct command string' if (str.match(regex).nil? || str.match(regex).size > 1)
    return true
  end

  def self.get_string_regex n
    regex = case n
      when 1 then /(C|S|X){1}/
      when 3 then /(I(\t%d){2}){1}/
      when 4 then /(L|F){1}(\t%d){2}([A-Z]){1}/
      when 5 then /(V|H){1}(\t%d){3}([A-Z]){1}/
    end
    return regex
  end

end