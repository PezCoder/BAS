class CreateAdminUsers < ActiveRecord::Migration
  def change
    create_table :admin_users do |t|

    	t.string "name",:limit=>50
    	t.string "email",:limit=>100
    	t.string "username",:null=>false,:limit=>50
    	t.text "password_digest"
      t.timestamps null: false
    end
  end
end
