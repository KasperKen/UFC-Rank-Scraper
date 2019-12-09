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


  def list_fighters
    ranks.select {|rank| rank.fighter}
  end

  


end
