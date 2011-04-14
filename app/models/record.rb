class Record < ActiveRecord::Base
  #Permisos
  def authorized_for_delete?
    false
  end

  def authorized_for_create?
    false
  end

  def authorized_for_edit?
    false
  end

  def to_label
    "Historial de #{self.table} - #{self.code}"
  end
end
