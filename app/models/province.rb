class Province < Location
  belongs_to :country, class_name: "Country"
  has_many :towns, foreign_key: :province_id, class_name: "Town"
end
