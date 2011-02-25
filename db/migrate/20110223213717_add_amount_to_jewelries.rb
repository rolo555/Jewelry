class AddAmountToJewelries < ActiveRecord::Migration
  def self.up
    add_column :jewelries, :amount, :decimal
  end

  def self.down
    remove_column :jewelries, :amount
  end
end
