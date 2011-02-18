class Debt < ActiveRecord::Base
  #Relaciones
  belongs_to :jewelry
  has_many :payments, :dependent => :destroy
  has_many :addresses, :dependent => :destroy
  has_many :phone_numbers, :dependent => :destroy

  #Validaciones
  validates_presence_of :debtor, :total_amount, :jewelry
  validates_uniqueness_of :jewelry_id

  def date_message
    payment_date.present? ? "#{I18n.t! 'sold_at' } #{I18n.l payment_date, :format => :long}" : "#{I18n.t 'nil_date'}"
  end

  def before_create
    jewelry.status = I18n.t! :not_payed if jewelry.present?
    nil
  end
end
