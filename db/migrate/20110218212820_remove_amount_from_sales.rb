class RemoveAmountFromSales < ActiveRecord::Migration
  def self.up
    remove_column :sales, :amount
  end

  def self.down
    add_column :sales, :amount, :decimal
  end
end
