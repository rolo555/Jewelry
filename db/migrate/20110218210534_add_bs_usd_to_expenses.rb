class AddBsUsdToExpenses < ActiveRecord::Migration
  def self.up
    add_column :expenses, :bs, :decimal
    add_column :expenses, :usd, :decimal
  end

  def self.down
    remove_column :expenses, :usd
    remove_column :expenses, :bs
  end
end
