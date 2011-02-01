class CreatePayments < ActiveRecord::Migration
  def self.up
    create_table :payments do |t|
      t.decimal :amount
      t.date :payment_date
      t.integer :debt_id

      t.timestamps
    end
  end

  def self.down
    drop_table :payments
  end
end
