class AddBsAndUsdToSales < ActiveRecord::Migration
  def self.up
    add_column :sales, :bs, :decimal
    add_column :sales, :usd, :decimal
  end

  def self.down
    remove_column :sales, :usd
    remove_column :sales, :bs
  end
end
