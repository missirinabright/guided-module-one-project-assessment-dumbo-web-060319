class Adult < ActiveRecord::Base
  has_many :farmchores
  has_many :children, through: :farmchores

  def self.adult_list
    Adult.all.each {|adult| puts adult.name}
  end

  def self.adult_hash
    new_hash_adult = {}
    Adult.all.each do |adult_object|
      new_hash_adult[adult_object.name] = adult_object
    end
    new_hash_adult
  end
end
