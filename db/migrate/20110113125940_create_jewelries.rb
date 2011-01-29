class CreateJewelries < ActiveRecord::Migration
  def self.up
    create_table :jewelries do |t|
      t.string :jewelry_code
      t.float :weight
      t.text :description
      t.string :photo_file_name
      t.string :photo_content_type
      t.integer :photo_file_size
      t.datetime :photo_updated_at
      t.date :purchase_date
      t.decimal :purchase_price
      t.string :status
      t.integer :box_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :jewelries
  end
end
