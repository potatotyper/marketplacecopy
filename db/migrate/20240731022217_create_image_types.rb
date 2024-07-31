class CreateImageTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :image_types do |t|
      t.string :image_name
      t.string :image_path
      t.string :image_id

      t.timestamps
    end
  end
end
