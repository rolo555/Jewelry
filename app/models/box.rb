include ModelHelper

class Box < ActiveRecord::Base
  protected :before_validation

  #Relaciones
  belongs_to :product

  #Validaciones
  validates_presence_of :code, :description
  validates_length_of :code, :maximum => 50, :if => "self.code.presence"
  validates_length_of :description, :maximum => 50, :if => "self.description.presence"
  validates_uniqueness_of :code, :case_sensitive => false

  def before_validation
    sanitizate_strings :code, :description
  end

  def to_label
    "#{code} - #{description}"
  end

end
