include ModelHelper

class Expense < ActiveRecord::Base
  protected :before_validation

  #Relaciones
  belongs_to :jewelry

  #Validaciones
  validates_numericality_of :amount, :greater_than_or_equal_to => 0, :if => "self.amount.present?"


end
