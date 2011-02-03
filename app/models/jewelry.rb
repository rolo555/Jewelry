include ModelHelper

class Jewelry < ActiveRecord::Base
  protected :before_validation

  #Relaciones
  belongs_to :box
  has_one :expense, :dependent => :destroy
  has_one :sale, :dependent => :destroy
  has_one :debt, :dependent => :destroy

  #Fotografia
  has_attached_file :photo,
    :styles => { :thumbnail => "100x100" },
    :default_url => "missing.png"

  def before_validation
    sanitizate_strings :jewelry_code
  end

  #Validaciones
  validates_presence_of :weight, :purchase_date, :purchase_price, :box

  def to_label
    "#{description}"
  end

  def after_create
    self.expense = Expense.new :created_at => self.created_at, :updated_at => self.updated_at
    self.expense.save
    nil
  end

  def before_create
    copy_product_auto_code
    box.product.increase_product_auto_code
    nil
  end

  def after_save
    self.expense.concept = "Compra de joya."
    self.expense.amount = self.purchase_price
    self.expense.save
    nil
  end

  def cash_sale_date_message
    sale.date_message if sale.present?
  end

  def sale_on_account_date_message
    debt.date_message if debt.present?
  end

  def copy_product_auto_code
    self.product_auto_code = box.product.product_auto_code 
  end

  private :copy_product_auto_code

  def sale_authorized_for_read?
    self.debt.blank?
  end

  def debt_authorized_for_read?
    self.sale.blank?
  end
end
