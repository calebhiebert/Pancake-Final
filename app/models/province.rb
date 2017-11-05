class Province < ApplicationRecord
  validates :gst, :pst, :hst, :province_code, presence: true
  validates :gst, :pst, :hst, numericality: { greater_than_or_equal_to: 0 }
  validates :province_code, length: { is: 2 }

  has_many :location
end
