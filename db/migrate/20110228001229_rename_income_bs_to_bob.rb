class RenameIncomeBsToBob < ActiveRecord::Migration
  def self.up
    rename_column(:incomes, :bs, :bob)
  end

  def self.down
    rename_column(:incomes, :bob, :bs)
  end
end
