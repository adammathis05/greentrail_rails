class Provider < ApplicationRecord
  belongs_to :site
  belongs_to :community
  has_and_belongs_to_many :tags, join_table: :provider_tags
end
