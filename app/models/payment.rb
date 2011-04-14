class Payment < ActiveRecord::Base

  #Relaciones
  belongs_to :debt
  has_one :income, :as => :payment, :dependent => :destroy

  #Validaciones
  validates_presence_of :amount, :payment_date
  validate :payment_date_cant_be_greater_than_today
  validates_numericality_of :amount, :greater_than => 0, :if => "self.amount.present?"

  def payment_date_cant_be_greater_than_today
    if self.payment_date.present? and self.payment_date > Date.today
      errors.add :payment_date, "#{I18n.t!('can\'t be greater than')} #{I18n.t!('today')}"
    end
  end

  def before_create
    self.currency = debt.currency
  end

  def after_create
    self.income = Income.new
    self.income.save!
    nil
  end

  def after_save
    update_income
    nil
  end

  def before_destroy
    Record.create :table => "Pago",
        :code => "Venta de la joya #{self.jewelry.jewelry_code}",
        :message => "Se eliminó un pago de #{self.amount_with_currency}"
  end

  def update_income
    self.income.concept = "#{I18n.t! "payment of", 
    :scope => "activerecord.attributes.payment"} #{debt.debtor} - #{debt.jewelry.to_label} - #{debt.jewelry.box.description}"
    self.income.update_amount self.amount, self.currency
    self.income.payment_date = self.payment_date
    self.income.save!
  end

  def jewelry
    debt.jewelry if debt.present?
  end

  def amount_with_currency
    "#{amount} #{I18n.t! currency}"
  end

  def to_label
    "#{self.amount_with_currency} - #{I18n.l payment_date, :format => :long}"
  end

end
