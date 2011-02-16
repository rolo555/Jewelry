class AddPaymentDateToIncomes < ActiveRecord::Migration
  def self.up
    add_column :incomes, :payment_date, :date
  end

  def self.down
    remove_column :incomes, :payment_date
  end
end
