class CreateFarmchores < ActiveRecord::Migration[5.2]
  def change
    create_table :farmchores do |t|
      t.string :description
      t.integer :adult_id
      t.integer :child_id
    end
  end
end
