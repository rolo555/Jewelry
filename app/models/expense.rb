include ModelHelper

class Expense < ActiveRecord::Base
  protected :before_validation

  #Relaciones
  belongs_to :jewelry

  #Validaciones
  validates_numericality_of :bs, :greater_than_or_equal_to => 0, :if => "self.bs.present?"
  validates_numericality_of :usd, :greater_than_or_equal_to => 0, :if => "self.usd.present?"

  def amounts=(amounts)
    self.bs, self.usd = amounts
  end
end
