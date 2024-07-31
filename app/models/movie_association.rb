class MovieAssociation < ApplicationRecord
  enum status: {
      movie1: 0,
      movie2: 1,
      movie3: 2
  }
end
