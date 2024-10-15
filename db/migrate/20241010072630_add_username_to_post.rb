class AddUsernameToPost < ActiveRecord::Migration[7.1]
  def change
    add_column :itemposts, :username, :string
    add_column :textposts, :username, :string
  end
end
