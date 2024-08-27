class CreateItemposts < ActiveRecord::Migration[7.1]
  def change
    create_table :itemposts do |t|
      t.string :title
      t.string :description
      t.string :image
      
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
