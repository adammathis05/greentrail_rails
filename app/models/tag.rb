class Tag < ApplicationRecord
    has_and_belongs_to_many :providers, join_table: :provider_tags
end
