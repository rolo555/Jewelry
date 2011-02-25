class Payment < ActiveRecord::Base
  #Relaciones
  belongs_to :debt
  has_one :income, :as => :payment, :dependent => :destroy

  #Validaciones
  validates_presence_of :amount, :payment_date
  validate :payment_date_cant_be_greater_than_today

  def to_label
    "#{amount}-#{payment_date}"
  end

  def before_create
    self.currency = debt.currency
  end

  def after_create
    self.income = Income.new :created_at => self.created_at, :updated_at => self.updated_at
    self.income.save
  end

  def after_save
    self.income.concept = "Pago de #{self.debt.debtor}"
    self.income.amounts = amounts
    self.income.payment_date = self.payment_date
    self.income.save
  end

  def payment_date_cant_be_greater_than_today
    unless self.payment_date.nil?
      if (self.payment_date <=> Date.today) > 0
        errors.add :payment_date, "#{I18n.t!('can\'t be greater than')} #{I18n.t!('today')}"
      end
    end
  end

  def bs
    amount if currency.eql? "BOB"
  end

  def usd
    amount if currency.eql? "USD"
  end

  def amounts
    [bs, usd]
  end

end
