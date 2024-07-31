class CreateMovieAssociations < ActiveRecord::Migration[7.1]
  def change
    create_table :movie_associations do |t|
      t.string :image_id
      t.integer :film_id

      t.timestamps
    end
  end
end
