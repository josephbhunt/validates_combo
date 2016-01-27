class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :hair_color
      t.string :eye_color
      t.integer :height
      t.integer :weight
      t.integer :shoe_size

      t.timestamps null: false
    end
  end
end
