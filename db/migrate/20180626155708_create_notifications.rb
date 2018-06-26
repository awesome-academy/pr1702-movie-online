class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.references :user, foreign_key: true
      t.integer :src_id
      t.string :src_type
      t.string :message

      t.timestamps
    end
  end
end
