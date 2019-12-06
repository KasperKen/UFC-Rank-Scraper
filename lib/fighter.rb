class Fighter

  extend Findable

  @@all = []


  attr_reader :name, :weightclass, :ranking, :record

  def initialize(name)
    @name = name
    @weightclass = []
  end


  def self.all
    WeightClass.all.detect {|weight| weight.fighters}
  end


  def save
    @@all << self
  end


  def self.all
    @@all
  end


  def is_number?(number)
    number.to_i.to_s == number
  end


  def add_weightclass(new_class)
    @weightclass << new_class if !@weightclass.include? new_class
  end


  def add_ranking(ranking)
    if ranking == 'C'
      @ranking = 'Champion'
    elsif is_number?(ranking)
      @ranking = ranking
    else
      @ranking = 'Not Ranked'
    end
  end


  def add_attributes(fighter_data)
    weightclass = fighter_data[:weight_class]
    ranking = fighter_data[:ranking]

    @record = fighter_data[:record]
    self.add_ranking(ranking)
    self.add_weightclass(weightclass)
  end 
  

  def self.create(name)
    new(name).tap {|fighter| fighter.save}
  end
  

end
