class Sale < ActiveRecord::Base
  #Relaciones
  belongs_to :jewelry
  has_one :income, :as => :payment, :dependent => :destroy

  #Validaciones
  validates_presence_of :amount, :date_of_sale
  validates_uniqueness_of :jewelry_id
  validate :date_of_sale_cant_be_greater_than_today

  def date_message
    "#{I18n.t! "sold_at"} #{I18n.l date_of_sale, :format => :long}"
  end

  def after_create
    self.income = Income.new :created_at => self.created_at, :updated_at => self.updated_at
    self.income.save
  end
  
  def after_save
    self.income.concept = "Venta de joya"
    self.income.amount = amount
    self.income.payment_date = self.date_of_sale
    self.income.save
  end

  def before_create
    jewelry.status = I18n.t!:payed if jewelry.present?
    nil
  end

  def date_of_sale_cant_be_greater_than_today
    unless self.date_of_sale.nil?
      if (self.date_of_sale <=> Date.today) > 0
        errors.add :date_of_sale, "#{I18n.t!('can\'t be greater than')} #{I18n.t!('today')}"
      end
    end
  end
end
