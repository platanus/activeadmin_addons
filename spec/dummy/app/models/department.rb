class Department < ActiveRecord::Base
  has_many :departments_cities
  accepts_nested_attributes_for :departments_cities, allow_destroy: true
end
