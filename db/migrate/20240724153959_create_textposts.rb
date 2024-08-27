class CreateTextposts < ActiveRecord::Migration[7.1]
  def change
    create_table :textposts do |t|
      t.string :post_title
      t.string :post_body
      
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
