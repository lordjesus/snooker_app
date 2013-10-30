class AddEmailAndPhoneToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :email, :string
    add_column :profiles, :phone, :string
  end
end
