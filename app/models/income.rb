class Income < ActiveRecord::Base
  #Relaciones
  belongs_to :payment, :polymorphic => true

  #Validation
  validates_numericality_of :amount, :greater_than_or_equal_to => 0, :if => "self.amount.present?"

  def to_label
    "#{concept}"
  end

  #Desactivar delete, update y create
  def authorized_for_delete?
    false
  end

  def authorized_for_update?
    false
  end

  def authorized_for_create?
    false
  end

end
