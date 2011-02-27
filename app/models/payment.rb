class Payment < ActiveRecord::Base
  #Relaciones
  belongs_to :debt
  has_one :income, :as => :payment, :dependent => :destroy

  #Validaciones
  validates_presence_of :amount, :payment_date
  validate :payment_date_cant_be_greater_than_today

  def payment_date_cant_be_greater_than_today
    if self.payment_date.present? and self.payment_date > Date.today
      errors.add :payment_date, "#{I18n.t!('can\'t be greater than')} #{I18n.t!('today')}"
    end
  end

  def before_create
    self.currency = debt.currency
  end

  def after_create
    self.income = Income.new :created_at => self.created_at, :updated_at => self.updated_at
    self.income.save!
  end

  def after_save
    self.income.concept = "#{I18n.t! "payment of", :scope => "activerecord.attributes.payment"} #{debt.debtor}"
    self.income.amounts = amounts
    self.income.payment_date = self.payment_date
    self.income.save!
  end

  def bs
    amount if currency.eql? "bob"
  end

  def usd
    amount if currency.eql? "usd"
  end

  def amounts
    [bs, usd]
  end

  def to_label
    "#{amount} #{I18n.t! currency, :scope => "activerecord.attributes.debt"} - #{I18n.l payment_date, :format => :long}"
  end

end
