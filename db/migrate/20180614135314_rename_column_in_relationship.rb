class RenameColumnInRelationship < ActiveRecord::Migration[5.0]
  def change
    rename_column :relationships, :user1_id, :user_id
    rename_column :relationships, :user2_id, :friend_id
  end
end
