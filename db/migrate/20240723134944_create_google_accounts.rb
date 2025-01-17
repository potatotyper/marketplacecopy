class CreateGoogleAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :google_accounts do |t|
      t.string :email
      t.string :image
      t.string :token
      t.string :refresh
      
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
