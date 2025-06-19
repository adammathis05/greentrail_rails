class Country < Location
  has_many :provinces, foreign_key: :country_id, class_name: "Province"
end
