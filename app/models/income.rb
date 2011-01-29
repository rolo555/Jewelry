class Income < ActiveRecord::Base
  #Relaciones
  belongs_to :payment, :polymorphic => true

  #Validation
  validates_numericality_of :amount, :greater_than_or_equal_to => 0, :if => "self.amount.present?"

  def to_label
    "#{concept}"
  end
end
