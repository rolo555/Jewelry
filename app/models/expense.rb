class Expense < ActiveRecord::Base

  CURRENCIES = [:usd, :bob]

  #Relaciones
  belongs_to :jewelry

  #Validaciones
  validates_numericality_of :bob, :greater_than_or_equal_to => 0, :if => "bob.present?"
  validates_numericality_of :usd, :greater_than_or_equal_to => 0, :if => "usd.present?"

  #Permisos
  def authorized_for_delete?
    false
  end

  def concept=(value)
    value.strip! if value.present?
    self.write_attribute(:concept, value)
  end

  def amounts=(amounts)
    CURRENCIES.each do |c|
      send("#{c}=", amounts[c])
    end
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
