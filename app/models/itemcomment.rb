class Itemcomment < ApplicationRecord
  belongs_to :itempost 
  belongs_to :user
end
