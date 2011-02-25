class Income < ActiveRecord::Base
  #Relaciones
  belongs_to :payment, :polymorphic => true

  #Validation
  validates_numericality_of :bs, :greater_than_or_equal_to => 0, :if => "self.bs.present?"
  validates_numericality_of :usd, :greater_than_or_equal_to => 0, :if => "self.usd.present?"

  def to_label
    "#{concept}"
  end

  def amounts=(amounts)
    self.bs, self.usd = amounts
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
