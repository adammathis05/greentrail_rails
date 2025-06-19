class Country < Location
  has_many :provinces, foreign_key: :country_id, class_name: "Province"

  alias_attribute :country_name, :name
end
