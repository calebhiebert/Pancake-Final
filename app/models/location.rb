class Location < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :province
end
