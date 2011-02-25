class Debt < ActiveRecord::Base
  #Relaciones
  belongs_to :jewelry
  has_many :payments, :dependent => :destroy
  has_many :addresses, :dependent => :destroy
  has_many :phone_numbers, :dependent => :destroy

  #Validaciones
  validates_presence_of :debtor, :total_amount, :jewelry, :payment_date
  validates_uniqueness_of :jewelry_id
  validate :payment_date_cant_be_greater_than_today

  validates_numericality_of :balance, :greater_than_or_equal_to => 0

  def date_message
    payment_date.present? ? "#{I18n.t! 'sold_at' } #{I18n.l payment_date, :format => :long}" : "#{I18n.t 'nil_date'}"
  end

  def after_save
    jewelry.status = I18n.t! :not_payed if jewelry.present?
    self.jewelry.save!
    nil
  end

  def payment_date_cant_be_greater_than_today
    unless self.payment_date.nil?
      if (self.payment_date <=> Date.today) > 0
        errors.add :payment_date, "#{I18n.t!('can\'t be greater than')} #{I18n.t!(:today)}"
      end
    end
  end
  
  def bs
    total_amount if currency.eql? "BOB"
  end

  def usd
    total_amount if currency.eql? "USD"
  end

  def price
    if bs
      "#{bs} #{as_(:Bs)}"
    else
      "#{usd} #{as_(:Usd)}"
    end
  end

  def before_validation
    self.balance = total_amount - payments.map{|p| p.amount}.sum
  end
end
