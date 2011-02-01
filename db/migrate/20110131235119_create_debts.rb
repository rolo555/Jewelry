class CreateDebts < ActiveRecord::Migration
  def self.up
    create_table :debts do |t|
      t.string :debtor
      t.decimal :total_amount
      t.decimal :balance
      t.integer :jewelry_id

      t.timestamps
    end
  end

  def self.down
    drop_table :debts
  end
end
