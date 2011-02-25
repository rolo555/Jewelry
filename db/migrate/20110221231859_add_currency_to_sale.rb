class AddCurrencyToSale < ActiveRecord::Migration
  def self.up
    add_column :sales, :currency, :string
  end

  def self.down
    remove_column :sales, :currency
  end
end
