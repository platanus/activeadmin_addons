require 'enumerize'
require 'paperclip'

class Invoice < ActiveRecord::Base
  extend ::Enumerize
  include Paperclip::Glue

  belongs_to :category
  belongs_to :city

  enumerize :state, in: [:pending, :rejected, :approved], default: :pending

  enum status: { active: 0, archived: 1 }

  has_attached_file :attachment
  validates_attachment :attachment, content_type: { content_type: "application/pdf" }

  has_attached_file :photo, styles: {
    big: "600x600>",
    medium: "300x300>",
    thumb: "100x100>"
  }

  validates_attachment :photo, content_type: { content_type: /\Aimage\/.*\Z/ }

  def display_name
    number
  end
end
