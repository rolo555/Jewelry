class CreateJewelries < ActiveRecord::Migration
  def self.up
    create_table :jewelries do |t|
      t.string :code
      t.float :weight
      t.string :description
      t.string :photo_file_name
      t.string :photo_content_type
      t.integer :photo_file_size
      t.datetime :photo_updated_at
      t.integer :product_id
      t.date :purchase_date
      t.decimal :purchase_price
      t.boolean :sold

      t.timestamps
    end
  end

  def self.down
    drop_table :jewelries
  end
end
