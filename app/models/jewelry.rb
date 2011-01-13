include ModelHelper

class Jewelry < ActiveRecord::Base
  protected :before_validation

  #Relaciones
  belongs_to :product

  #Fotografia
  has_attached_file :photo,
    :styles => { :thumbnail => "100x100" },
    :default_url => "missing.png"

  #Validaciones
  validates_presence_of :


end
