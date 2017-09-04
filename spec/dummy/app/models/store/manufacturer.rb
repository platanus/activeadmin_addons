module Store
  class Manufacturer < ActiveRecord::Base
    has_many :cars
  end
end
