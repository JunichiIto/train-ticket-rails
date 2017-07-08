class CreateGates < ActiveRecord::Migration[5.1]
  def change
    create_table :gates do |t|
      t.string :name, null: false
      t.integer :number, null: false

      t.timestamps
    end
    add_index :gates, :name, unique: true
    add_index :gates, :number, unique: true
  end
end
