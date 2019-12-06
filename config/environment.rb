#BSD 3-Clause License

#Copyright (c) 2019, Kenneth Andrews
#All rights reserved.

require 'pry'
require_relative '../lib/concerns/findable.rb'
require_relative '../lib/scraper.rb'
require_relative '../lib/fighter.rb'
require_relative '../lib/weight-class.rb'

scraper = Scraper.create
scraper.start
WeightClass.add_from_fighters
binding.pry
