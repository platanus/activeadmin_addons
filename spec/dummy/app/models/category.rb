class Category < ActiveRecord::Base
  def shiny_name
    "My shiny #{name}"
  end
end
