include ModelHelper

class Box < ActiveRecord::Base
  protected :before_validation

  #Relaciones
  belongs_to :product
  has_many :jewelries

  #Validaciones
  validates_presence_of :box_code, :description
  validates_length_of :box_code, :maximum => 50, :if => "self.box_code.presence"
  validates_length_of :description, :maximum => 50, :if => "self.description.presence"
  validates_uniqueness_of :box_code, :case_sensitive => false, :scope => :product_id

  def before_validation
    sanitizate_strings :box_code, :description
  end

  def to_label
    "#{box_code} - #{description}"
  end

end
