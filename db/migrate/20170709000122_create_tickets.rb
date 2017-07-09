class CreateTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :tickets do |t|
      t.integer :fare, null: false
      t.integer :entered_gate_id

      t.timestamps
    end
    add_index :tickets, :entered_gate_id
  end
end
