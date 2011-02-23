class AddCurrencyToJewelries < ActiveRecord::Migration
  def self.up
    add_column :jewelries, :currency, :string
  end

  def self.down
    remove_column :jewelries, :currency
  end
end
