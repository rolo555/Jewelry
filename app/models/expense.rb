include ModelHelper

class Expense < ActiveRecord::Base

  #Relaciones
  belongs_to :jewelry

  #Validaciones
  validates_numericality_of :bs, :greater_than_or_equal_to => 0, :if => "bs.present?"
  validates_numericality_of :usd, :greater_than_or_equal_to => 0, :if => "usd.present?"

  #Permisos
  def authorized_for_delete?
    false
  end

  def amounts=(amounts)
    self.bs, self.usd = amounts
  end

  def price
    "#{amount} #{I18n.t! currency, :scope => "activerecord.attributes.expense"}" if amount.present?
  end

  def currency
    if bs.present?
      "bob"
    elsif usd.present?
      "usd"
    end
  end

  def amount
    if bs.present?
      bs
    elsif usd.present?
      usd
    end
  end

  def to_label
    product = jewelry.to_label if jewelry.present?
    date = I18n.l(payment_date, :format => :long) if payment_date.present?
    [concept, product, date].join " "
  end

end
