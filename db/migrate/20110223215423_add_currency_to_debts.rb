class AddCurrencyToDebts < ActiveRecord::Migration
  def self.up
    add_column :debts, :currency, :string
  end

  def self.down
    remove_column :debts, :currency
  end
end
