class Location < ApplicationRecord
    has_many :saved_locations, dependent: :destroy
    has_many :users, through: :saved_locations
    has_many :api_usages, dependent: :nullify
end
