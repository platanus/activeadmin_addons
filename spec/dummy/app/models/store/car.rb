module Store
  class Car < ActiveRecord::Base
    belongs_to :manufacturer
  end
end
