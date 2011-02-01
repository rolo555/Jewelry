include ModelHelper

class PhoneNumber < ActiveRecord::Base

  protected :before_validation

  #Relaciones
  belongs_to :debt

  #Validaciones
  validates_presence_of :number
  validates_length_of :number, :maximum => 50, :if => "self.number.presence"

  def to_label
    number.to_s
  end

  def before_validation
    sanitizate_strings :number
  end
end