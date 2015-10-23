class AddStreetAddressToComplaint < ActiveRecord::Migration

  def change
    add_column :complaints, :street_address, :string
  end

end
