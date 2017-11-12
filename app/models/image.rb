class Image < ApplicationRecord
  validates :ident, :ext, presence: true

  belongs_to :product
end
