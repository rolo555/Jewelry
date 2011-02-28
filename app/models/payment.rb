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
    self.income = Income.new
    self.income.save!
    nil
  end

  def after_save
    self.income.concept = "#{I18n.t! "payment of", :scope => "activerecord.attributes.payment"} #{debt.debtor} - #{debt.jewelry.to_label}"
    self.income.update_amount self.amount, self.currency
    self.income.payment_date = self.payment_date
    self.income.save!
    nil
  end

  def to_label
    "#{amount} #{I18n.t! currency} - #{I18n.l payment_date, :format => :long}"
  end

end
