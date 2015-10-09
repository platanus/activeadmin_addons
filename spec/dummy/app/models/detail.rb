class Detail < ActiveRecord::Base
  belongs_to :invoice

  def display_name
    code
  end
end
