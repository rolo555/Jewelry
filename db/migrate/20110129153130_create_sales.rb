class CreateSales < ActiveRecord::Migration
  def self.up
    create_table :sales do |t|
      t.decimal :amount
      t.integer :jewelry_id
      t.date :date_of_sale

      t.timestamps
    end
  end

  def self.down
    drop_table :sales
  end
end
