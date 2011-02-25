class RemoveAmountFromIncomes < ActiveRecord::Migration
  def self.up
    remove_column :incomes, :amount
  end

  def self.down
    add_column :incomes, :amount, :decimal
  end
end
