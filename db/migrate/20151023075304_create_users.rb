class CreateUsers < ActiveRecord::Migration

  def change
    create_table :users do |t|
      t.string :email_address
      t.string :password_digest
      t.string :name
      t.text :access_token
      t.timestamps null: false
    end
  end

end
