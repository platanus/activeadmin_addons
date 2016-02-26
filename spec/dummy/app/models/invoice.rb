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

  def skills
    ["Animation", "Branding", "Creative Director"]
  end

  def contact
    { "twitter" => "goku84", "facebook" => "kamehouse" }
  end

  def details
    {
      title: "Detalle",
      categories: ["home", "investment"],
      picture: {
        path: "invoice.png",
        size: "5MB",
        geo: {
          lat: 12.34343,
          lng: 34.4343
        }
      }
    }
  end
end
