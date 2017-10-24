class Location < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_one :province
end
