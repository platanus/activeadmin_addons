require 'enumerize'
require 'paperclip'

class Invoice < ActiveRecord::Base
  extend ::Enumerize
  include Paperclip::Glue

  enumerize :state, in: [:pending, :rejected, :approved], default: :pending

  enum status: { active: 0, archived: 1 }

  has_attached_file :attachment
  validates_attachment :attachment, content_type: { content_type: "application/pdf" }

  has_attached_file :photo
  validates_attachment :photo, content_type: { content_type: /\Aimage\/.*\Z/ }
end
