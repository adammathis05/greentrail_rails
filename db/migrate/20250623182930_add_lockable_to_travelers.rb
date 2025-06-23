class AddLockableToTravelers < ActiveRecord::Migration[7.2]
  def change
    add_column :travelers, :failed_attempts, :integer, default: 0, null: false # Only if lock strategy is :failed_attempts
    add_column :travelers, :unlock_token, :string # Only if unlock strategy is :email or :both
    add_column :travelers, :locked_at, :datetime

    add_index :travelers, :unlock_token, unique: true
  end
end
