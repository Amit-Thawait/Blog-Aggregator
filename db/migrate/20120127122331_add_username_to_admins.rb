class AddUsernameToAdmins < ActiveRecord::Migration
  def change
	  add_column :admins, :user_name, :string
  end
end
