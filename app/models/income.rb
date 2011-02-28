class Income < ActiveRecord::Base

  #Relaciones
  belongs_to :payment, :polymorphic => true

  #Validation
  validates_numericality_of :bs, :greater_than_or_equal_to => 0, :if => "bs.present?"
  validates_numericality_of :usd, :greater_than_or_equal_to => 0, :if => "usd.present?"

  #Permisos
  def authorized_for_delete?
    false
  end

  def authorized_for_update?
    false
  end

  def authorized_for_create?
    false
  end

  def amounts=(amounts)
    self.bs, self.usd = amounts
  end

  def price
    "#{amount} #{I18n.t! currency, :scope => "activerecord.attributes.income"}" if amount.present?
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

  def self.payment_types
    all.map {|p| p.payment_type}.uniq
  end

  def to_label
    "#{concept}"
  end

end
