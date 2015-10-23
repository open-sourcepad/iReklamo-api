class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :complaint_id
      t.integer :user_id

      t.timestamps
    end

    add_index :likes, :complaint_id
    add_index :likes, :user_id
  end
end
