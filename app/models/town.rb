class Town < Location
  belongs_to :province, class_name: "Province"
  has_many :sites, dependent: :destroy
  has_one :community, dependent: :destroy

  alias_attribute :town_name, :name
end
