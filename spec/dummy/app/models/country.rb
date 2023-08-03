class Country < ActiveRecord::Base
  has_many :regions, dependent: :destroy
  has_many :cities, through: :regions

  def self.ransackable_attributes(_auth_object = nil)
    ["created_at", "id", "information", "name", "updated_at"]
  end

  def self.ransackable_associations(_auth_object = nil)
    ["regions", "cities"]
  end
end
