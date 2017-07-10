class RenameNumberToStationNumberInGates < ActiveRecord::Migration[5.1]
  def change
    rename_column :gates, :number, :station_number
  end
end
