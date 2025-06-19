class Town < Location
  belongs_to :province, class_name: "Province"
  has_one :community
  has_many :sites

  alias_attribute :town_name, :name
end
