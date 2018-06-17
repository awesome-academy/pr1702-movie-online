class RenameColumnInRelationship < ActiveRecord::Migration[5.0]
  def change
    rename_column :relationships, :user1_id, :requesting_id
    rename_column :relationships, :user2_id, :requested_id
  end
end
