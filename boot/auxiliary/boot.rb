##
# This module used to load our lib path to metasploit $LOAD_PATH
# This is a silly hack until msf team allows us to load ~/.msf4/lib natively
##

require 'pathname'

module_pathname = Pathname.new(__FILE__).realpath
module_types = %w(auxiliary exploits encoders evasion payloads post nops)

root_index = module_types.map do |module_dir|
  module_pathname.to_path.split("/").find_index(module_dir)
end.join().to_i

root = module_pathname.to_path.split("/")[0..root_index - 2].join("/")
root_path = Pathname.new(root)

lib_path = root_path.join('lib').to_path

unless $LOAD_PATH.include? lib_path
  $LOAD_PATH.unshift lib_path
end
