class AddPaymentDateToDebts < ActiveRecord::Migration
  def self.up
    add_column :debts, :payment_date, :date
  end

  def self.down
    remove_column :debts, :payment_date
  end
end
