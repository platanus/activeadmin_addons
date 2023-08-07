class Category < ActiveRecord::Base
  has_many :invoices

  def shiny_name
    "My shiny #{name}"
  end

  def self.ransackable_attributes(_auth_object = nil)
    ["created_at", "description", "id", "name", "updated_at"]
  end

  def self.ransackable_associations(_auth_object = nil)
    ["invoices"]
  end
end
