class Expense < ActiveRecord::Base

  CURRENCIES = [:usd, :bob]

  #Relaciones
  belongs_to :jewelry

  #Validaciones
  validates_numericality_of :bob, :greater_than_or_equal_to => 0, :if => "bob.present?"
  validates_numericality_of :usd, :greater_than_or_equal_to => 0, :if => "usd.present?"
  validates_presence_of :concept
  validates_presence_of :payment_date, :unless => "self.jewelry.present?"

  validate :payment_date_cant_be_greater_than_today, :uniqueness_of_currency

  def after_create
    create_record "Se creó con un monto de #{self.price}"
  end

  def before_update
    message = ""
    message += "Se modificó la fecha de pago
    Antes era '#{payment_date_was}' y ahora es '#{payment_date}'
    " if payment_date_changed?
    message += "Se modificó el concepto
    Antes era '#{concept_was}' y ahora es '#{concept}'
    " if concept_changed?
    message += "Se modificó el monto en bolivianos
    Antes era '#{bob_was}' y ahora es '#{bob}'
    " if bob_changed?
    message += "Se modificó el monto en dolares
    Antes era '#{usd_was}' y ahora es '#{usd}'" if usd_changed?
    create_record message if message.present?
  end

  def uniqueness_of_currency
    if (self.bob.present? and self.usd.present?) or (self.bob.blank? and self.usd.blank?)
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

  def authorized_for_edit?
    self.jewelry.blank?
  end

  def concept=(value)
    value.strip! if value.present?
    self.write_attribute(:concept, value)
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

  def create_record(message)
    Record.create :table => "Egreso",
      :code => "'#{self.concept}' de la fecha #{self.payment_date}",
      :message => message
  end

end

