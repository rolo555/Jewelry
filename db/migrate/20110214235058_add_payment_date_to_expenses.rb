class AddPaymentDateToExpenses < ActiveRecord::Migration
  def self.up
    add_column :expenses, :payment_date, :date
  end

  def self.down
    remove_column :expenses, :payment_date
  end
end
