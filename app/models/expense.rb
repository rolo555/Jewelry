include ModelHelper

class Expense < ActiveRecord::Base
  protected :before_validation

  #Relaciones
  belongs_to :jewelry

  #Validaciones
  validates_numericality_of :bs, :greater_than_or_equal_to => 0, :if => "self.bs.present?"
  validates_numericality_of :usd, :greater_than_or_equal_to => 0, :if => "self.usd.present?"

  #Desactivar delete
  def authorized_for_delete?
    false
  end

  def amounts=(amounts)
    self.bs, self.usd = amounts
  end

  def to_label
    product = jewelry.to_label if jewelry.present?
    date = I18n.l(payment_date, :format => :long) if payment_date.present?
    [concept, product, date].join " "
  end
end
