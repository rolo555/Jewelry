class CreateRecords < ActiveRecord::Migration
  def self.up
    create_table :records do |t|
      t.string :table
      t.string :code
      t.text :message

      t.timestamps
    end
  end

  def self.down
    drop_table :records
  end
end
