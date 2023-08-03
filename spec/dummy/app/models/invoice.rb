require 'aasm'

class Invoice < ActiveRecord::Base
  include AASM
  include ImageUploader::Attachment(:picture)
  after_initialize :set_default_state, if: :new_record?

  belongs_to :category
  belongs_to :city
  has_and_belongs_to_many :items
  has_and_belongs_to_many :other_items, class_name: 'Item'

  enum state: {
    pending: 'pending',
    rejected: 'rejected',
    approved: 'approved'
  }

  enum status: { active: 0, archived: 1 }

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

  def set_default_state
    self.state ||= 'pending'
  end

  def self.ransackable_attributes(_auth_object = nil)
    [
      "aasm_state", "active", "amount", "attachment_content_type", "attachment_file_name",
      "attachment_file_size", "attachment_updated_at", "category_id", "city_id", "client_id",
      "color", "created_at", "description", "id", "legal_date", "number", "paid",
      "photo_content_type", "photo_file_name", "photo_file_size", "photo_updated_at",
      "picture_data", "position", "shipping_status", "state", "status", "updated_at"
    ]
  end

  def self.ransackable_associations(_auth_object = nil)
    ["category", "city", "items", "other_items"]
  end
end
