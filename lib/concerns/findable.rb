module Findable


  def find_by_name(name)
    all.detect{|a| a.name == name}
  end


  def find_no_case(name)
    all.detect{|a| a.name.casecmp(name) == 0}
  end


  def find_by_include(input)
    all.find_all {|a| a.name.downcase.include?(input.downcase)}
  end 

  def object_exists?(name)
    all.any? {|a| a.name == name}
  end


end

