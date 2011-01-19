include ModelHelper

class Product < ActiveRecord::Base
  protected :before_validation

  #Relaciones
  has_many :boxes, :dependent => :destroy
  has_many :jewelries, :through => :boxes

  #Validaciones
  validates_presence_of :name, :boxes
  validates_length_of :name, :maximum => 50, :if => "self.name.presence"
  validates_uniqueness_of :name, :case_sensitive => false

  def before_validation
    sanitizate_strings :name
  end

  def to_label
    "#{name}"
  end

end
