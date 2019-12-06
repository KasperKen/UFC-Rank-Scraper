class WeightClass

  extend Findable

  @@all = []

  attr_reader :name, :fighters


  def initialize(name)
    @name = name
  end


  def self.all
    @@all
  end


  def save
    @@all << self
  end


  def add_fighters(fighters)
    @fighters << fighters
  end


  def self.create(name)
    new(name).tap {|weightclass| weightclass.save}
  end

  def fighters
    Fighter.all.detect {|fighter| fighter.weightclass == self.name}
  end


  def self.add_from_fighters
    Fighter.all.each do |fighter| 
      self.create(fighter.weightclass) unless self.all.any? {|wc| wc.name == fighter.weightclass}
    end
  end


end
