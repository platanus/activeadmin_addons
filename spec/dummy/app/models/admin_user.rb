class AdminUser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
    :recoverable, :rememberable, :trackable, :validatable

  has_many :invoices, foreign_key: :client_id

  # adding this to test proc values
  def categories_url
    '/admin/categories'
  end
end
