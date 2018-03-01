class DepartmentsCity < ActiveRecord::Base
  has_many :departments
  has_many :cities
end
