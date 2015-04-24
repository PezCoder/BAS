class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
    	t.references :user

    	t.string "title",:limit=>100
    	t.text "description"
    	t.string "category",:limit=>100
    	t.string "sub_category",:limit=>100
    	t.string "type",:limit=>50
		t.string "brand",:limit=>100
    	t.integer "price"
    	t.boolean "used"

      t.timestamps null: false
    end
    add_index("products","user_id")
  end

end
