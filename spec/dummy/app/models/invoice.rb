require 'enumerize'

class Invoice < ActiveRecord::Base
  extend ::Enumerize

  enumerize :state, in: [:pending, :rejected, :approved], default: :pending

  enum status: { active: 0, archived: 1 }
end
