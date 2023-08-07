class Item < ActiveRecord::Base
  has_and_belongs_to_many :invoices

  def full_name
    "##{id} - #{name}"
  end

  def self.ransackable_attributes(_auth_object = nil)
    ["created_at", "description", "id", "name", "updated_at"]
  end

  def self.ransackable_associations(_auth_object = nil)
    ["invoices"]
  end
end
