class Farmchore < ActiveRecord::Base
  belongs_to :adult
  belongs_to :child

  def self.farmchore_list
    Farmchore.all.each {|farmchore| puts farmchore.description}
  end

  def self.farmchore_hash
    new_hash_farmchore = {}
    Farmchore.all.each do |farmchore_object|
      new_hash_farmchore[farmchore_object.description] = farmchore_object
    end
    new_hash_farmchore
  end
end
