class Location < ApplicationRecord
  validates :address, :postal_code, :province, presence: true

  belongs_to :user, dependent: :destroy
  belongs_to :province
end
