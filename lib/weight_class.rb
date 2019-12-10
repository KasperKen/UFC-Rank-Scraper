#BSD 3-Clause License
#Copyright (c) 2019, Kenneth Andrews All rights reserved.
#All rights reserved.

class WeightClass

  extend Findable

  @@all = []

  attr_reader :name, :rankings

  def initialize(name)
    @name = name
    self.save
  end


  def self.all
    @@all
  end


  def save
    @@all << self
  end

  
  def self.weightclass_exists?(name)
    WeightClass.find_by_name(name)
  end
  

  def ranks
    Rank.all.select {|rank| rank.weightclass == self}
  end


  def fighters
    ranks.map {|rank| rank.fighter}
  end

  


end
