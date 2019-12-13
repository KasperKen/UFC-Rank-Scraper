#BSD 3-Clause License
#Copyright (c) 2019, Kenneth Andrews All rights reserved.
#All rights reserved.

class WeightClass

  extend Findable

  @@all = []

  attr_reader :name

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
    self.ranks.map {|rank| rank.fighter}
  end

  
  def find_fighter_by_weight(input)
    self.fighters.find_all {|fighter| fighter.name.downcase.include?(input.downcase)}
  end
  


end
