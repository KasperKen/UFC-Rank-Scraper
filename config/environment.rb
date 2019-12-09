#BSD 3-Clause License

#Copyright (c) 2019, Kenneth Andrews
#All rights reserved.

require 'pry'
require 'Nokogiri'

require_relative '../lib/concerns/findable.rb'
require_relative '../lib/concerns/tools.rb'
require_relative '../lib/scraper.rb'
require_relative '../lib/fighter.rb'
require_relative '../lib/weight_class.rb'
require_relative '../lib/cli.rb'
require_relative '../lib/rank.rb'

scraper = Scraper.new
scraper.start

cli = Cli.new
cli.main_menu

binding.pry
