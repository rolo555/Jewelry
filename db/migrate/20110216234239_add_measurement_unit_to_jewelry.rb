class AddMeasurementUnitToJewelry < ActiveRecord::Migration
  def self.up
    add_column :jewelries, :measurement_unit, :string
  end

  def self.down
    remove_column :jewelries, :measurement_unit
  end
end
