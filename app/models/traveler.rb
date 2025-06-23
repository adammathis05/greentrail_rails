class Traveler < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :lockable
  validates :first, :last, :email, presence: true

  enum role: { traveler: "traveler", admin: "admin" }

  # Validations
  validates :role, presence: true

  # Optional helper in ApplicationController
  def admin_only!
    redirect_to root_path, alert: "Access denied." unless current_traveler&.admin?
  end

  def full_name
    "#{first} #{last}"
  end
end
