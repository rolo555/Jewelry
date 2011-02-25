class RemoveBsAndUsdAmountFromJewelries < ActiveRecord::Migration
  def self.up
    remove_column :jewelries, :usd
    remove_column :jewelries, :bs
  end

  def self.down
    add_column :jewelries, :bs, :decimal
    add_column :jewelries, :usd, :decimal
  end
end
