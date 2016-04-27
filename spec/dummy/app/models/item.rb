class Item < ActiveRecord::Base
  has_and_belongs_to_many :invoices

  def full_name
    "##{id} - #{name}"
  end
end
