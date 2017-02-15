#
# An IRB alternative and runtime developer console
#   https://github.com/pry/pry
#

pry_aliases = {
  "c" => "continue",
  "s" => "step",
  "n" => "next"
}

pry_aliases.each do |command_alias, command_name|
  next if Pry.commands[command_name].nil?
  Pry.commands.alias_command(command_alias, command_name)
end
