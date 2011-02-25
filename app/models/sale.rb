class Sale < ActiveRecord::Base
  #Relaciones
  belongs_to :jewelry
  has_one :income, :as => :payment, :dependent => :destroy

  #Validaciones
  validates_presence_of :date_of_sale, :amount, :currency
  validates_uniqueness_of :jewelry_id
  validate :date_of_sale_cant_be_greater_than_today

  def date_message
    "#{I18n.t! "sold_at"} #{I18n.l date_of_sale, :format => :long}"
  end

  def after_create
    self.income = Income.new :created_at => self.created_at, :updated_at => self.updated_at
    self.income.save
    nil
  end
  
  def after_save
    self.income.concept = "Venta de joya"
    self.income.amounts = amounts
    self.income.payment_date = self.date_of_sale
    self.income.save
    jewelry.status = I18n.t!:payed if jewelry.present?
    self.jewelry.save!
    nil
  end

  def date_of_sale_cant_be_greater_than_today
    if self.date_of_sale.present? and self.date_of_sale > Date.today
      errors.add :date_of_sale, "#{I18n.t!('can\'t be greater than')} #{I18n.t!('today')}"
    end
  end

  def bs
    amount if currency.eql? "BOB"
  end

  def usd
    amount if currency.eql? "USD"
  end

  def amounts
    [self.bs, self.usd]
  end

  def price
    if bs
      "#{bs} #{as_(:BOB)}"
    else
      "#{usd} #{as_(:USD)}"
    end
  end

  def self.currencies
    [[as_(:BOB), "BOB"], [as_(:USD), "USD"]]
  end
end
