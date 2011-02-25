class Debt < ActiveRecord::Base
  #Relaciones
  belongs_to :jewelry
  has_many :payments, :dependent => :destroy
  has_many :addresses, :dependent => :destroy
  has_many :phone_numbers, :dependent => :destroy

  #Validaciones
  validates_presence_of :debtor, :total_amount, :jewelry
  validates_uniqueness_of :jewelry_id
  validates_numericality_of :balance, :greater_than_or_equal_to => 0

  def date_message
    "#{I18n.t! 'sold_at' } #{I18n.l created_at, :format => :long}"
  end

  def before_create
    jewelry.status = I18n.t! :not_payed if jewelry.present?
    nil
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
