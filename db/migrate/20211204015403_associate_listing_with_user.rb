class AssociateListingWithUser < ActiveRecord::Migration[5.2]
  def change
    add_column :listings, :uid, :string
    add_column :listings, :phone, :string
  end
end
