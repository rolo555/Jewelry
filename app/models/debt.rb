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
    "#{as_:sold_at} #{created_at.strftime("%d %B %Y - %H:%M")}"
  end

end
