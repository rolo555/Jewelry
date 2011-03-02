class Debt < ActiveRecord::Base

  def after_initialize
    if new_record?
      self.payment_date ||= Date.today
    end
  end

  #Relaciones
  belongs_to :jewelry
  has_many :payments, :dependent => :destroy
  has_many :addresses, :dependent => :destroy
  has_many :phone_numbers, :dependent => :destroy

  #Validaciones
  validates_presence_of :debtor, :total_amount, :payment_date, :currency
  validates_uniqueness_of :jewelry_id
  validate :payment_date_cant_be_greater_than_today
  validates_numericality_of :balance, :greater_than_or_equal_to => 0, :if => "balance.present?"

  delegate :status, :to => :jewelry, :allow_nil => true

  def payment_date_cant_be_greater_than_today
    if self.payment_date.present? and self.payment_date > Date.today
      errors.add :payment_date, "#{I18n.t!('can\'t be greater than')} #{I18n.t!(:today)}"
    end
  end

  def authorized_for_delete?
    false
  end

  def date_message
    payment_date.present? ? "#{I18n.t! 'sold_at' } #{I18n.l payment_date, :format => :long}" : "#{I18n.t 'nil_date'}"
  end

  def before_validation
    self.balance = total_amount - payments.map{|p| p.amount}.sum if payments.present?
  end

  def before_save
    self.balance = self.total_amount if self.total_amount.present? and self.payments.blank?
  end

  def after_save
    jewelry.update_status if jewelry.present?
    nil
  end

  def price
    "#{total_amount} #{I18n.t!(currency) if currency.present?}"
  end

  def balance_with_currency
    "#{balance} #{I18n.t!(currency) if currency.present?}" if balance.present?
  end

  def debtor=(value)
    value.strip! if value.present?
    self.write_attribute(:debtor, value)
  end

  def payed?
    balance == 0
  end

  def self.status_types
    all.map {|d| d.status}.uniq
  end

  def update_incomes
    if self.payments.present?
      self.payments.each do |p|
        p.update_income
      end
    end
  end

  def to_label
    product = jewelry.to_label if jewelry.present?
    date = I18n.l(payment_date, :format => :long) if payment_date.present?
    [debtor, product, date].join " "
  end

end
