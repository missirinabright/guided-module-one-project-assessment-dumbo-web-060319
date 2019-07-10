class CreateAdults < ActiveRecord::Migration[5.2]
  def change
    create_table :adults do |t|
      t.string :name
    end
  end
end
