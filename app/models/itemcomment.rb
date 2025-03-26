class Itemcomment < ApplicationRecord
  belongs_to :textpost 
  belongs_to :user
end
