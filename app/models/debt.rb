class Debt < ActiveRecord::Base
  #Relaciones
  belongs_to :jewelry
  has_many :payments, :dependent => :destroy

  #Validaciones
  validates_presence_of :debtor, :total_amount, :jewelry
  validates_uniqueness_of :jewelry_id

  def to_label
    "Deuda"
  end

end
