class Payment < ActiveRecord::Base
  #Relaciones
  belongs_to :debt
  has_one :income, :as => :payment, :dependent => :destroy

  #Validaciones
  validates_presence_of :amount, :payment_date

  def to_label
    "#{amount}-#{payment_date}"
  end

  def after_create
    self.income = Income.new :created_at => self.created_at, :updated_at => self.updated_at
    self.income.save
  end

  def after_save
    self.income.concept = "Pago de #{self.debt.debtor}"
    self.income.amount = amount
    self.income.save
  end

end
