class City < ActiveRecord::Base
  belongs_to :region
  has_many :departments_cities, dependent: :destroy
  has_many :departments, through: :departments_cities

  def self.ransackable_attributes(_auth_object = nil)
    ["created_at", "id", "information", "name", "region_id", "updated_at"]
  end

  def self.ransackable_associations(_auth_object = nil)
    ["region", "deparments_cities", "departments"]
  end
end
