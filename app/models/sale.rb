class Sale < ActiveRecord::Base

  #Relaciones
  belongs_to :jewelry
  has_one :income, :as => :payment, :dependent => :destroy

  #Validaciones
  validates_presence_of :date_of_sale, :amount, :currency
  validates_uniqueness_of :jewelry_id
  validate :date_of_sale_cant_be_greater_than_today

  def date_of_sale_cant_be_greater_than_today
    if self.date_of_sale.present? and self.date_of_sale > Date.today
      errors.add :date_of_sale, "#{I18n.t!('can\'t be greater than')} #{I18n.t!('today')}"
    end
  end

  def date_message
    "#{I18n.t! "sold at", :scope => "activerecord.attributes.sale"} #{I18n.l date_of_sale, :format => :long}"
  end

  def after_create
    income = Income.new
    income.save
    nil
  end

  def after_save
    update_income
    jewelry.update_status if jewelry.present?
    nil
  end

  def update_income
    income.concept = I18n.t! "jewelry sale"
    income.amounts = amounts
    income.payment_date = self.date_of_sale
    income.save
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

  def price
    "#{amount} #{I18n.t! currency, :scope => "currencies"}"
  end

end
