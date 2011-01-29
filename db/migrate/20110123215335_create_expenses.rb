class CreateExpenses < ActiveRecord::Migration
  def self.up
    create_table :expenses do |t|
      t.string :concept
      t.decimal :amount
      t.integer :jewelry_id

      t.timestamps
    end
  end

  def self.down
    drop_table :expenses
  end
end
