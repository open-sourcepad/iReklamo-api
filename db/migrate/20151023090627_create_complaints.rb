class CreateComplaints < ActiveRecord::Migration

  def change
    create_table :complaints do |t|
      t.integer :user_id
      t.string :title
      t.text :description
      t.float :latitude
      t.float :longitude
      t.string :category
      t.timestamps null: false
    end
    add_attachment :complaints, :image
  end

end
