class RemoveAmountFromExpenses < ActiveRecord::Migration
  def self.up
    remove_column :expenses, :amount
  end

  def self.down
    add_column :expenses, :amount, :decimal
  end
end
