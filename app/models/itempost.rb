class Itempost < ApplicationRecord
  belongs_to :user

  has_many :itemcomments
end
