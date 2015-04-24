class CreateUsersAdminUsersJoin < ActiveRecord::Migration
  def change
    create_table :admin_users_users do |t|
    	t.references :admin_user
    	t.references :user
    end
    add_index("admin_users_users",["admin_user_id","user_id"])
  end
end
