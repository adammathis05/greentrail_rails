class AddConfirmableToTravelers < ActiveRecord::Migration[7.2]
  def change
    add_column :travelers, :confirmation_token, :string
    add_column :travelers, :confirmed_at, :datetime
    add_column :travelers, :confirmation_sent_at, :datetime
    add_column :travelers, :unconfirmed_email, :string # Only if using reconfirmable

    add_index :travelers, :confirmation_token, unique: true
  end
end
