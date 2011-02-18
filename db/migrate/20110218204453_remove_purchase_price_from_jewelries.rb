class RemovePurchasePriceFromJewelries < ActiveRecord::Migration
  def self.up
    remove_column :jewelries, :purchase_price
  end

  def self.down
    add_column :jewelries, :purchase_price, :decimal
  end
end
