#BSD 3-Clause License
#Copyright (c) 2019, Kenneth Andrews All rights reserved.
#All rights reserved.

class Rank

  include Tools

  attr_reader :fighter, :weightclass, :rank

  @@all = []

  def initialize(rank, fighter, weightclass)
    @rank = format_rank(rank)
    @fighter = fighter
    @weightclass = weightclass

    self.save
  end


  def self.all
    @@all
  end
  
  def format_rank(ranking)
    if ranking == 'C'
      rank = 'Champion'
    elsif is_number?(ranking)
      rank = ranking
    else
      rank = 'Not Ranked'
    end
    rank
  end
 

  def save
    @@all << self
  end

end
