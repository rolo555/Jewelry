class AddProductAutoCodeToJewelry < ActiveRecord::Migration
  def self.up
    add_column :jewelries, :product_auto_code, :integer
  end

  def self.down
    remove_column :jewelries, :product_auto_code
  end
end
