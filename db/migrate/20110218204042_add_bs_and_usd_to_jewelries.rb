class AddBsAndUsdToJewelries < ActiveRecord::Migration
  def self.up
    add_column :jewelries, :bs, :decimal
    add_column :jewelries, :usd, :decimal
  end

  def self.down
    remove_column :jewelries, :usd
    remove_column :jewelries, :bs
  end
end
