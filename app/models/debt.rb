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
  validates_numericality_of :balance, :greater_than_or_equal_to => 0, :if => "self.balance.present?"

  def payment_date_cant_be_greater_than_today
    if self.payment_date.present? and self.payment_date > Date.today
      errors.add :payment_date, "#{I18n.t!('can\'t be greater than')} #{I18n.t!(:today)}"
    end
  end

  #Permisos
  def authorized_for_create?
    false
  end

  def authorized_for_delete?
    false
  end

  def date_message
    payment_date.present? ? "#{I18n.t! 'sold_at' } #{I18n.l payment_date, :format => :long}" : "#{I18n.t 'nil_date'}"
  end

  def before_validation
    self.balance = total_amount - payments.map{|p| p.amount}.sum
  end

  def after_save
    jewelry.status = I18n.t! :not_payed if jewelry.present?
    self.jewelry.save!
    nil
  end

  def price
    "#{total_amount} #{I18n.t! currency, :scope => "activerecord.attributes.debt"}"
  end

  def debtor=(value)
    value.strip! if value.present?
    self.write_attribute(:debtor, value)
  end

end
