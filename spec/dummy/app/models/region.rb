class Region < ActiveRecord::Base
  belongs_to :country
  has_many :cities, dependent: :destroy

  def self.ransackable_attributes(_auth_object = nil)
    ["country_id", "created_at", "id", "information", "name", "updated_at"]
  end

  def self.ransackable_associations(_auth_object = nil)
    ["country", "cities"]
  end
end
