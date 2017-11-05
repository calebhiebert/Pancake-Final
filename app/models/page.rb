class Page < ApplicationRecord
  validates :title, :content, presence: true
  validates :title, length: { in: 3..255 }
  validates :content, length: { in: 3..16_000 }
end
