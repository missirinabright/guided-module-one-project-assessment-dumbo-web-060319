class Child < ActiveRecord::Base
  has_many :farmchores
  has_many :adults, through: :farmchores

  def self.child_list
    Child.all.each {|child| puts child.name}
    #this is the class method that I created to use in a method to list all the
    #names of the children (r_see_the_current_kids_team)
  end

  def self.child_hash
    #I created a hash to turn an array of kids objects into a hash so that I could access the
    #keys (for the name), while storing their values (id's)
    #I used this in the method c_create_farmchore where I needed to access the names
    #and store their values to clreate a farmchore that is a join and consists of
    #an id from each of the other models - adult and child. 
    new_hash_child = {}
    Child.all.each do |child_object|
      new_hash_child[child_object.name] = child_object
    end
    new_hash_child
  end
end
