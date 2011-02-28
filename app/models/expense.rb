class Expense < ActiveRecord::Base

  CURRENCIES = [:usd, :bob]

  #Relaciones
  belongs_to :jewelry

  #Validaciones
  validates_numericality_of :bob, :greater_than_or_equal_to => 0, :if => "bob.present?"
  validates_numericality_of :usd, :greater_than_or_equal_to => 0, :if => "usd.present?"

  validate :payment_date_cant_be_greater_than_today, :uniqueness_of_currency

  def uniqueness_of_currency
    if self.bob.present? and self.usd.present?
      errors.add_to_base "#{I18n.t('uniqueness_of_currency')}"
    end
  end

  def payment_date_cant_be_greater_than_today
    if self.payment_date.present? and self.payment_date > Date.today
      errors.add :payment_date, "#{I18n.t!('can\'t be greater than')} #{I18n.t!(:today)}"
    end
  end

  #Permisos
  def authorized_for_delete?
    false
  end

  def concept=(value)
    value.strip! if value.present?
    self.write_attribute(:concept, value)
  end

  def update_amount(amount, currency)
    CURRENCIES.each { |c|
      self.send("#{c}=", nil)
    }
    self.send("#{currency}=", amount)
  end

  def price
    "#{amount} #{I18n.t! currency}" if amount.present?
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

  def to_label
    product = jewelry.to_label if jewelry.present?
    date = I18n.l(payment_date, :format => :long) if payment_date.present?
    [concept, product, date].join " "
  end

end
