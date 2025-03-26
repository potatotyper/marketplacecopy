class AddUsernameToPost < ActiveRecord::Migration[7.1]
  def change
    add_column :textposts, :price, :string
  end
end
