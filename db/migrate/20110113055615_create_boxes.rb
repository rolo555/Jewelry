class CreateBoxes < ActiveRecord::Migration
  def self.up
    create_table :boxes do |t|
      t.string :code
      t.string :description
      t.integer :product_id

      t.timestamps
    end
  end

  def self.down
    drop_table :boxes
  end
end
