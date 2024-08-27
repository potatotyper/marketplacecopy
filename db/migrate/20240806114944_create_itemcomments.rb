class CreateItemcomments < ActiveRecord::Migration[7.1]
  def change
    create_table :itemcomments do |t|
      t.string :post_body
      
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :itempost, null: false, foreign_key: true

      t.timestamps
    end
  end
end
