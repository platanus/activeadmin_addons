class Category < ActiveRecord::Base
  has_many :invoices
  def shiny_name
    "My shiny #{name}"
  end
end
