class Invoice < ActiveRecord::Base
  validates :number, presence: true
end
