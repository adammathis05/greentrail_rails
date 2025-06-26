class Traveler < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :lockable
  

  enum role: { traveler: "traveler", admin: "admin" }
  before_validation :assign_default_role, on: :create

  # Validations
  validates :role, presence: true
  validates :first, :last, :email, presence: true
  validates :home_city, :home_country, length: { maximum: 100 }

  # Optional helper in ApplicationController
  def admin_only!
    redirect_to root_path, alert: "Access denied." unless current_traveler&.admin?
  end

  def full_name
    "#{first} #{last}"
  end

  private

  def assign_default_role
    self.role ||= :traveler
  end
end
