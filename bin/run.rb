require_relative '../config/environment.rb'
require_relative '../lib/cli.rb'

cli = CLI.new
cli.greet
cli.main_menu
