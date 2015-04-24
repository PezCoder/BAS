class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|

    	t.string "name",:limit=>50
    	t.string "username",:limit=>50,:null=>false
    	t.string "city",:limit=>50
    	t.string "mobile_no",:limit=>10
    	t.string "email",:limit=>100
      t.text "password_digest"
      t.timestamps null: false
    end
    add_index("users","username")
  end

end
