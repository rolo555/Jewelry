class AddBsAndUsdToIncomes < ActiveRecord::Migration
  def self.up
    add_column :incomes, :bs, :decimal
    add_column :incomes, :usd, :decimal
  end

  def self.down
    remove_column :incomes, :usd
    remove_column :incomes, :bs
  end
end
