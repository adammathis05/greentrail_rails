class Traveler < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :lockable


  enum role: [ :traveler, :admin ]  # ✅ Recommended format
  before_validation :set_default_role, on: [ :create, :update ]

  has_one_attached :profile_picture
  has_many :saved_communities, dependent: :destroy
  has_many :saved_community_records, through: :saved_communities, source: :community

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

  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= :traveler
  end
end
