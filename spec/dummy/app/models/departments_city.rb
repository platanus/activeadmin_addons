class DepartmentsCity < ActiveRecord::Base
  belongs_to :department
  belongs_to :city
end
