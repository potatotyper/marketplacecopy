class Textpost < ApplicationRecord
  belongs_to :user
  validates :post_title, presence: true
  validates :post_body, presence: true
end
