class Income < ActiveRecord::Base

  CURRENCIES = [:usd, :bob]

  #Relaciones
  belongs_to :payment, :polymorphic => true

  #Validation
  validates_numericality_of :bob, :greater_than_or_equal_to => 0, :if => "bob.present?"
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

  def update_amount(amount, currency)
    if amount.present? and currency.present?
      CURRENCIES.each { |c|
      self.send("#{c}=", nil)
      }
      self.send("#{currency}=", amount)
    end
  end

  def price
    "#{amount} #{I18n.t! currency }" if amount.present?
  end

  def currency
    currencies = CURRENCIES.map { |c|
      c if eval("self.#{c}.present?")
    }.compact
    currencies.first unless currencies.empty?
  end

  def amount
    currencies = CURRENCIES.map { |c|
      eval("self.#{c}")
    }.compact
    currencies.first unless currencies.empty?
  end

  def self.payment_types
    all.map {|p| p.payment_type}.uniq
  end

  def to_label
    "#{concept}"
  end

end
