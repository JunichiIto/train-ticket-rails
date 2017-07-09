class AddExitedGateToTickets < ActiveRecord::Migration[5.1]
  def change
    add_column :tickets, :exited_gate_id, :integer
    add_index :tickets, :exited_gate_id
  end
end
