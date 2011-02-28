class RenameBsOfExpense < ActiveRecord::Migration
  def self.up
    rename_column(:expenses, :bs, :bob)
  end

  def self.down
    rename_column(:expenses, :bob, :bs)
  end
end
