require 'enumerize'
require 'paperclip'
require 'aasm'

class Invoice < ActiveRecord::Base
  extend ::Enumerize
  include Paperclip::Glue
  include AASM
  include ImageUploader::Attachment(:picture)

  belongs_to :category
  belongs_to :city
  has_and_belongs_to_many :items
  has_and_belongs_to_many :other_items, class_name: 'Item'

  enumerize :state, in: [:pending, :rejected, :approved], default: :pending

  enum status: { active: 0, archived: 1 }

  has_attached_file :attachment
  validates_attachment :attachment, content_type: { content_type: "application/pdf" }

  has_attached_file :photo, styles: {
    big: "600x600>",
    medium: "300x300>",
    thumb: "100x100>"
  }

  validates_attachment :photo, content_type: { content_type: %r{\Aimage\/.*\Z} }

  # Uncomment to test validations
  # validates :city, :city_id, :category, :category_id, :updated_at, :number, :item_ids, :color,
  #   :state, :amount, presence: true

  aasm do
    state :pending, initial: true
    state :accepted, :rejected

    event :accept do
      transitions from: :pending, to: :accepted
    end

    event :reject do
      transitions from: :pending, to: :rejected
    end
  end

  aasm :shipping, column: :shipping_status do
    state :stock, initial: true
    state :transit, :received

    event :ship do
      transitions from: :stock, to: :transit
    end

    event :confirm do
      transitions from: :transit, to: :received
    end
  end

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
