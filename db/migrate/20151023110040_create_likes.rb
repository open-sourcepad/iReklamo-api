class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :complaint_id
      t.integer :user_id

      t.timestamps
    end

    add_index :likes, [:user_id, :complaint_id]
  end
end
