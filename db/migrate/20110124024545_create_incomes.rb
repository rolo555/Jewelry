class CreateIncomes < ActiveRecord::Migration
  def self.up
    create_table :incomes do |t|
      t.string :concept
      t.decimal :amount
      t.integer :payment_id
      t.string :payment_type

      t.timestamps
    end
  end

  def self.down
    drop_table :incomes
  end
end
