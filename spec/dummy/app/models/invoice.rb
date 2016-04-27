require 'enumerize'
require 'paperclip'

class Invoice < ActiveRecord::Base
  extend ::Enumerize
  include Paperclip::Glue

  belongs_to :category
  belongs_to :city
  has_and_belongs_to_many :items

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

  def self.colors
    [
      "#DD2900",
      "#D94000",
      "#D55500",
      "#D26A00",
      "#CE7D00",
      "#CA9000",
      "#C6A300",
      "#C2B400",
      "#B9BF00"
    ]
  end
end
